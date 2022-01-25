package Mhj::User;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use DBI;
use File::Spec;
use FindBin;
use Data::Dumper;
use JSON::PP;
use Encode qw(encode decode);

sub run {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    return $self->_get($options)    if $options->{method} eq 'get';
    return $self->_insert($options) if $options->{method} eq 'insert';
    return $self->_update($options) if $options->{method} eq 'update';
    return $self->_delete($options) if $options->{method} eq 'delete';
    return print encode_json $self->_error_msg;
    return;
}

sub _build_dbh {
    my ( $self, @args ) = @_;
    my $db   = File::Spec->catfile( "$FindBin::RealBin", '..', 'db', 'mhj.db' );
    my $attr = +{
        RaiseError     => 1,
        AutoCommit     => 1,
        sqlite_unicode => 1,
    };
    my $dbh = DBI->connect( "dbi:SQLite:dbname=$db", "", "", $attr );
    return $dbh;
}

# $self->_single($table, \@cols, \%params);
sub _single {
    my ( $self, $table, $cols, $params ) = @_;
    my $sql_q = [];
    for my $col ( @{$cols} ) {
        push @{$sql_q}, qq{$col = "$params->{$col}"};
    }
    push @{$sql_q}, qq{deleted = 0};
    my $sql_clause = join " AND ", @{$sql_q};
    my $sql        = qq{SELECT * FROM $table WHERE $sql_clause};
    my $dbh        = $self->_build_dbh;
    return $dbh->selectrow_hashref($sql);
}

sub _delete {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $id      = $params->{id};
    my $dt      = $self->time_stamp;
    my $row     = $self->_single( 'user', ['id'], $params );
    return print encode( 'UTF-8', "not exist user: id\n" ) if !$row;
    my $set_clause = qq{deleted = 1,modified_ts = "$dt"};
    my $sql        = qq{UPDATE user SET $set_clause WHERE id = $id};
    my $dbh        = $self->_build_dbh;
    my $sth        = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    print encode_json {};
    print "\n";
    return;
}

sub _update {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $dt      = $self->time_stamp;
    my $row     = $self->_single( 'user', ['id'], $params );
    return print encode( 'UTF-8', "not exist user: id\n" ) if !$row;
    my $set_cols   = [ 'loginid', 'password' ];
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
    my $sql          = qq{UPDATE user SET $set_clause WHERE $where_clause};
    my $dbh          = $self->_build_dbh;
    my $sth          = $dbh->prepare($sql);
    $sth->execute() or die $dbh->errstr;
    my $update = $self->_single( 'user', ['id'], { id => $params->{id} } );
    print encode_json $update;
    print "\n";
    return;
}

sub _insert {
    my ( $self, @args ) = @_;
    my $options  = shift @args;
    my $params   = $options->{params};
    my $loginid  = $params->{loginid};
    my $password = $params->{password};
    my $dt       = $self->time_stamp;
    my $row      = $self->_single( 'user', ['loginid'], $params );
    return print encode( 'UTF-8', "exist user: $loginid\n" ) if $row;
    my $dbh = $self->_build_dbh;
    my $col = q{loginid, password, approved, deleted, created_ts, modified_ts};
    my $values = q{?, ?, ?, ?, ?, ?};
    my @data   = ( $loginid, $password, 1, 0, $dt, $dt );
    my $sql    = qq{INSERT INTO user ($col) VALUES ($values)};
    my $sth    = $dbh->prepare($sql);
    $sth->execute(@data) or die $dbh->errstr;
    my $id     = $dbh->last_insert_id( undef, undef, undef, undef );
    my $create = $self->_single( 'user', ['id'], { id => $id } );
    print encode_json $create;
    print "\n";
    return;
}

sub _get {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $loginid = $params->{loginid};
    my $row     = $self->_single( 'user', ['loginid'], $params );
    return print encode( 'UTF-8', "not exist user: $loginid\n" ) if !$row;
    print encode_json $row;
    print "\n";
    return;
}

sub _error_msg {
    my ( $self, @args ) = @_;
    my $error = +{
        error => +{
            code    => 400,
            message => 'error msg',
        }
    };
    return $error;
}

1;

__END__
