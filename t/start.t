use strict;
use warnings;
use utf8;
use Test::More;
use Data::Dumper;
use FindBin;
use lib ("$FindBin::RealBin/../lib");
use Mhj;
use Mhj::CGI;

subtest 'Class and Method' => sub {
    my @methods =
      qw{new build user period periodtype error time_stamp build_dbh single rows};
    can_ok( new_ok('Mhj'),        (@methods) );
    can_ok( new_ok('Mhj::Build'), ( qw{run _init},      @methods ) );
    can_ok( new_ok('Mhj::CGI'),   ( qw{run},            @methods ) );
    can_ok( new_ok('Mhj::Error'), ( qw{output  commit}, @methods ) );
    can_ok( new_ok('Mhj::Period'),
        ( qw{run _delete _update _insert _list}, @methods ) );
    can_ok( new_ok('Mhj::PeriodType'),
        ( qw{run _delete _update _insert _list}, @methods ) );
    can_ok( new_ok('Mhj::User'),
        ( qw{run _delete _update _insert _get}, @methods ) );
};

subtest 'Build' => sub {
    my $build     = new_ok('Mhj::Build');
    my $error_msg = $build->run();
    my @keys      = keys %{$error_msg};
    my $key       = shift @keys;
    ok( $key eq 'error', 'error message' );
    my $msg       = $build->run( { method => 'init' } );
    my $build_msg = 'build success mhj-test.db';
    ok( $msg->{message} eq $build_msg, $build_msg );
};

done_testing;
