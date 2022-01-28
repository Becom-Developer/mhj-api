package Mhj::Period;
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
    return $self->_list($options) if $options->{method} eq 'list';

    # return $self->_insert($options) if $options->{method} eq 'insert';
    # return $self->_update($options) if $options->{method} eq 'update';
    # return $self->_delete($options) if $options->{method} eq 'delete';
    return $self->error->commit(
        "Method not specified correctly: $options->{method}");
}

sub _list {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $id      = $params->{period_type_id};
    my $row     = $self->single( 'period_type', ['id'], { id => $id } );
    return $self->error->commit("not exist period_type: $id") if !$row;
    return $row;
}

# sub _delete {
#     my ( $self, @args ) = @_;
#     my $options = shift @args;
#     my $params  = $options->{params};
#     my $id      = $params->{id};
#     my $dt      = $self->time_stamp;
#     my $row     = $self->_single( 'user', ['id'], $params );
#     return $self->error->commit("not exist user id: $id") if !$row;
#     my $set_clause = qq{deleted = 1,modified_ts = "$dt"};
#     my $sql        = qq{UPDATE user SET $set_clause WHERE id = $id};
#     my $dbh        = $self->_build_dbh;
#     my $sth        = $dbh->prepare($sql);
#     $sth->execute() or die $dbh->errstr;
#     return {};
# }

# sub _update {
#     my ( $self, @args ) = @_;
#     my $options = shift @args;
#     my $params  = $options->{params};
#     my $dt      = $self->time_stamp;
#     my $row     = $self->_single( 'user', ['id'], $params );
#     return $self->error->commit("not exist user id: $params->{id}") if !$row;
#     my $set_cols   = [ 'loginid', 'password' ];
#     my $where_cols = ['id'];
#     my $set_q      = [];

#     for my $col ( @{$set_cols} ) {
#         push @{$set_q}, qq{$col = "$params->{$col}"};
#     }
#     push @{$set_q}, qq{modified_ts = "$dt"};
#     my $set_clause = join ",", @{$set_q};

#     my $where_q = [];
#     for my $col ( @{$where_cols} ) {
#         push @{$where_q}, qq{$col = "$params->{$col}"};
#     }
#     push @{$where_q}, qq{deleted = 0};
#     my $where_clause = join " AND ", @{$where_q};
#     my $sql          = qq{UPDATE user SET $set_clause WHERE $where_clause};
#     my $dbh          = $self->_build_dbh;
#     my $sth          = $dbh->prepare($sql);
#     $sth->execute() or die $dbh->errstr;
#     my $update = $self->_single( 'user', ['id'], { id => $params->{id} } );
#     return $update;
# }

# sub _insert {
#     my ( $self, @args ) = @_;
#     my $options  = shift @args;
#     my $params   = $options->{params};
#     my $loginid  = $params->{loginid};
#     my $password = $params->{password};
#     my $dt       = $self->time_stamp;
#     my $row      = $self->_single( 'user', ['loginid'], $params );
#     return $self->error->commit("exist user: $loginid") if $row;
#     my $dbh = $self->_build_dbh;
#     my $col = q{loginid, password, approved, deleted, created_ts, modified_ts};
#     my $values = q{?, ?, ?, ?, ?, ?};
#     my @data   = ( $loginid, $password, 1, 0, $dt, $dt );
#     my $sql    = qq{INSERT INTO user ($col) VALUES ($values)};
#     my $sth    = $dbh->prepare($sql);
#     $sth->execute(@data) or die $dbh->errstr;
#     my $id     = $dbh->last_insert_id( undef, undef, undef, undef );
#     my $create = $self->_single( 'user', ['id'], { id => $id } );
#     return $create;
# }

# sub _get {
#     my ( $self, @args ) = @_;
#     my $options = shift @args;
#     my $params  = $options->{params};
#     my $loginid = $params->{loginid};
#     my $row     = $self->_single( 'user', ['loginid'], $params );
#     return $self->error->commit("not exist user: $loginid") if !$row;
#     return $row;
# }

1;

__END__
