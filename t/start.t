use strict;
use warnings;
use utf8;
use Test::More;
use Data::Dumper;
use FindBin;
use lib ( "$FindBin::RealBin/../lib", "$FindBin::RealBin/../local/lib/perl5" );
use Mhj;
use Mhj::CGI;
$ENV{"MHJ_MODE"} = 'test';

subtest 'Class and Method' => sub {
    my @methods =
      qw{new build user period periodtype error time_stamp db_file build_dbh single rows};
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

subtest 'User' => sub {
    my $build = new_ok('Mhj::Build');
    $build->run( { method => 'init' } );
    my $user      = new_ok('Mhj::User');
    my $error_msg = $user->run();
    my @keys      = keys %{$error_msg};
    my $key       = shift @keys;
    ok( $key eq 'error', 'error message' );
    my $insert_q = +{
        path   => "user",
        method => "insert",
        params => +{
            loginid  => 'info@becom.co.jp',
            password => "info"
        }
    };
    my $insert = $user->run($insert_q);
    ok( $insert->{loginid} eq $insert_q->{params}->{loginid},   'insert' );
    ok( $insert->{password} eq $insert_q->{params}->{password}, 'insert' );

    my $get_q = +{
        path   => "user",
        method => "get",
        params => +{ loginid => $insert->{loginid}, }
    };
    my $get = $user->run($get_q);
    ok( $get->{loginid} eq $insert->{loginid},   'get' );
    ok( $get->{password} eq $insert->{password}, 'get' );

    my $update_q = +{
        path   => "user",
        method => "update",
        params => +{
            id       => $insert->{id},
            loginid  => 'info2@becom.co.jp',
            password => "info2"
        }
    };
    my $update = $user->run($update_q);
    ok( $update->{loginid} eq $update_q->{params}->{loginid},   'update' );
    ok( $update->{password} eq $update_q->{params}->{password}, 'update' );

    my $delete_q = +{
        path   => "user",
        method => "delete",
        params => +{ id => $insert->{id}, }
    };
    my $delete = $user->run($delete_q);
    ok( !%{$delete}, 'delete' );
};

subtest 'PeriodType' => sub {
    my $build = new_ok('Mhj::Build');
    $build->run( { method => 'init' } );
    my $periodtype = new_ok('Mhj::PeriodType');
    my $error_msg  = $periodtype->run();
    my @keys       = keys %{$error_msg};
    my $key        = shift @keys;
    ok( $key eq 'error', 'error message' );

    my $insert_q = +{
        path   => "periodtype",
        method => "insert",
        params => +{ title => '日本の歴史', }
    };
    my $insert = $periodtype->run($insert_q);
    ok( $insert->{title} eq $insert_q->{params}->{title}, 'insert' );

    my $list_q = +{
        path   => "periodtype",
        method => "list",
        params => +{}
    };
    my $list = $periodtype->run($list_q);
    ok( $list->{period_type}->[0]->{title} eq $insert->{title}, 'list' );

    my $update_q = +{
        path   => "periodtype",
        method => "update",
        params => +{
            id    => $insert->{id},
            title => '日本の歴史と社会歴史',
        }
    };
    my $update = $periodtype->run($update_q);
    ok( $update->{title} eq $update_q->{params}->{title}, 'update' );

    my $delete_q = +{
        path   => "periodtype",
        method => "delete",
        params => +{ id => $insert->{id}, }
    };
    my $delete = $periodtype->run($delete_q);
    ok( !%{$delete}, 'delete' );
};

done_testing;
