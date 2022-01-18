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

    # 初期設定時のdbファイル準備
    return $self->_get($options) if $options->{method} eq 'get';
    return;
}

sub _get {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    my $userid  = $options->{userid};
    my $db   = File::Spec->catfile( "$FindBin::RealBin", '..', 'db', 'mhj.db' );
    my $attr = +{
        RaiseError     => 1,
        AutoCommit     => 1,
        sqlite_unicode => 1,
    };
    my $dbh = DBI->connect( "dbi:SQLite:dbname=$db", "", "", $attr );
    my $sql = qq{SELECT * FROM user WHERE login_id = '$userid' };
    my $row = $dbh->selectrow_hashref($sql);
    return print encode( 'UTF-8', "not exist user: $userid\n" ) if !$row;
    print encode_json $row;
    print "\n";
    return;
}

1;

__END__
