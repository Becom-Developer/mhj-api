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

sub _check_loginid {
    my ( $self, @args ) = @_;
    my $loginid = shift @args;
    my $dbh     = $self->_build_dbh;
    my $sql     = qq{SELECT * FROM user WHERE loginid = '$loginid' };
    return $dbh->selectrow_hashref($sql);
}

sub _get_id {
    my ( $self, @args ) = @_;
    my $id  = shift @args;
    my $dbh = $self->_build_dbh;
    my $sql = qq{SELECT * FROM user WHERE id = '$id' };
    return $dbh->selectrow_hashref($sql);
}

sub _insert {
    my ( $self, @args ) = @_;
    my $options  = shift @args;
    my $params   = $options->{params};
    my $loginid  = $params->{loginid};
    my $password = $params->{password};
    my $dt       = $self->time_stamp;
    my $row      = $self->_check_loginid($loginid);
    return print encode( 'UTF-8', "exist user: $loginid\n" ) if $row;
    my $dbh = $self->_build_dbh;
    my $col = q{loginid, password, approved, deleted, created_ts, modified_ts};
    my $values = q{?, ?, ?, ?, ?, ?};
    my @data   = ( $loginid, $password, 1, 0, $dt, $dt );
    my $sql    = qq{INSERT INTO user ($col) VALUES ($values)};
    my $sth    = $dbh->prepare($sql);
    $sth->execute(@data) or die $dbh->errstr;
    my $id     = $dbh->last_insert_id();
    my $create = $self->_get_id($id);
    print encode_json $create;
    print "\n";
    return;
}

sub _get {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $params  = $options->{params};
    my $loginid = $params->{loginid};
    my $row     = $self->_check_loginid($loginid);
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
