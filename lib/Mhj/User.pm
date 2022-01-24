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
    my $id     = $dbh->last_insert_id();
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
