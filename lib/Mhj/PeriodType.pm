package Mhj::PeriodType;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use DBI;
use File::Spec;
use FindBin;
use Data::Dumper;

sub run {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    return $self->_list($options)   if $options->{method} eq 'list';
    return $self->_insert($options) if $options->{method} eq 'insert';
    return $self->_update($options) if $options->{method} eq 'update';
    return $self->_delete($options) if $options->{method} eq 'delete';
    return $self->error->commit(
        "Method not specified correctly: $options->{method}");
}

sub _delete {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $id      = $params->{id};
    my $dt      = $self->time_stamp;
    my $row     = $self->single( 'period_type', ['id'], $params );
    return $self->error->commit("not exist user id: $id") if !$row;
    my $set_clause = qq{deleted = 1,modified_ts = "$dt"};
    my $sql        = qq{UPDATE period_type SET $set_clause WHERE id = $id};
    my $dbh        = $self->build_dbh;
    my $sth        = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    return {};
}

sub _list {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $rows    = $self->rows( 'period_type', [], {} );
    return $self->error->commit("not exist period_type: ") if @{$rows} eq 0;
    return { period_type => $rows };
}

sub _update {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $dt      = $self->time_stamp;
    my $row     = $self->single( 'period_type', ['id'], $params );
    return $self->error->commit("not exist period_type id: $params->{id}")
      if !$row;
    my $set_cols   = ['title'];
    my $where_cols = ['id'];
    my $set_q      = [];

    for my $col ( @{$set_cols} ) {
        push @{$set_q}, qq{$col = "$params->{$col}"};
    }
    push @{$set_q}, qq{modified_ts = "$dt"};
    my $set_clause = join ",", @{$set_q};

    my $where_q = [];
    for my $col ( @{$where_cols} ) {
        push @{$where_q}, qq{$col = "$params->{$col}"};
    }
    push @{$where_q}, qq{deleted = 0};
    my $where_clause = join " AND ", @{$where_q};
    my $sql = qq{UPDATE period_type SET $set_clause WHERE $where_clause};
    my $dbh = $self->build_dbh;
    my $sth = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    my $update =
      $self->single( 'period_type', ['id'], { id => $params->{id} } );
    return $update;
}

sub _insert {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $title   = $params->{title};
    my $dt      = $self->time_stamp;
    my $row     = $self->single( 'period_type', ['title'], $params );
    return $self->error->commit("exist period_type: $title") if $row;
    my $dbh    = $self->build_dbh;
    my $col    = q{title, deleted, created_ts, modified_ts};
    my $values = q{?, ?, ?, ?};
    my @data   = ( $title, 0, $dt, $dt );
    my $sql    = qq{INSERT INTO period_type ($col) VALUES ($values)};
    my $sth    = $dbh->prepare($sql);
    $sth->execute(@data) or die $dbh->errstr;
    my $id     = $dbh->last_insert_id( undef, undef, undef, undef );
    my $create = $self->single( 'period_type', ['id'], { id => $id } );
    return $create;
}

1;

__END__
