package Mhj::Period;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
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
    my $table   = 'period';
    my $dt      = $self->time_stamp;
    my $row     = $self->single( $table, ['id'], $params );
    return $self->error->commit("not exist $table id: $id") if !$row;
    my $set_clause = qq{deleted = 1,modified_ts = "$dt"};
    my $sql        = qq{UPDATE $table SET $set_clause WHERE id = $id};
    my $dbh        = $self->build_dbh;
    my $sth        = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    return {};
}

sub _update {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $table   = 'period';
    my $dt      = $self->time_stamp;
    my $row     = $self->single( $table, ['id'], $params );
    return $self->error->commit("not exist $table id: $params->{id}") if !$row;
    my $set_cols = [
        'period_type_id', 'title', 'start_year', 'end_year',
        'start_ts',       'end_ts'
    ];
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
    my $sql          = qq{UPDATE $table SET $set_clause WHERE $where_clause};
    my $dbh          = $self->build_dbh;
    my $sth          = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    my $update = $self->single( $table, ['id'], { id => $params->{id} } );
    return $update;
}

sub _insert {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $table   = 'period';
    my $dt      = $self->time_stamp;
    my $row     = $self->single( $table, ['title'], $params );
    return $self->error->commit("exist $table: $params->{title}") if $row;
    my $dbh = $self->build_dbh;
    my $col =
q{period_type_id, title, start_year, end_year, start_ts, end_ts, deleted, created_ts, modified_ts};
    my $values = q{?, ?, ?, ?, ?, ?, ?, ?, ?};
    my @data   = (
        $params->{period_type_id}, $params->{title},
        $params->{start_year},     $params->{end_year},
        $params->{start_ts},       $params->{end_ts},
        0,                         $dt,
        $dt
    );
    my $sql = qq{INSERT INTO $table ($col) VALUES ($values)};
    my $sth = $dbh->prepare($sql);
    $sth->execute(@data) or die $dbh->errstr;
    my $id     = $dbh->last_insert_id( undef, undef, undef, undef );
    my $create = $self->single( $table, ['id'], { id => $id } );
    return $create;
}

sub _list {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $id      = $params->{period_type_id};
    my $row     = $self->single( 'period_type', ['id'], { id => $id } );
    return $self->error->commit("not exist period_type: $id") if !$row;
    my $rows = $self->rows( 'period', ['period_type_id'], $params );
    return +{
        period_type => $row,
        period      => $rows,
    };
}

1;

__END__
