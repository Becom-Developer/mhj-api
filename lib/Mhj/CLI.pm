package Mhj::CLI;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use Encode qw(encode decode);
use Data::Dumper;
use Getopt::Long;
use JSON::PP;

my ( $path, $method, $params ) = ( '', '', '{}' );
GetOptions(
    "path=s"   => \$path,
    "method=s" => \$method,
    "params=s" => \$params
) or die("Error in command line arguments\n");
my $options = +{
    path   => decode( 'UTF-8', $path ),
    method => decode( 'UTF-8', $method ),
    params => decode_json $params,
};
sub hello { print "hello CLI-----\n"; }

sub run {
    my ( $self, @args ) = @_;

    # 初期設定 / データベース設定更新 build
    if ( $options->{path} eq 'build' ) {
        print encode_json $self->build->run($options);
        print "\n";
        return;
    }

    # 登録ユーザー
    if ( $options->{path} eq 'user' ) {
        print encode_json $self->user->run($options);
        print "\n";
        return;
    }

    # 時代に関する情報の取得
    if ( $options->{path} eq 'period' ) {
        print encode_json $self->period->run($options);
        print "\n";
        return;
    }
    if ( $options->{path} eq 'periodtype' ) {
        print encode_json $self->periodtype->run($options);
        print "\n";
        return;
    }

    # 検索 search
    # 追加、更新
    return $self->error->output(
        "The path is specified incorrectly: $options->{path}");
}

1;

__END__

path, method の付け方の参考
https://developers.google.com/blogger/docs/3.0/reference

データベースの初期設定
mhj --path=build --method=init
