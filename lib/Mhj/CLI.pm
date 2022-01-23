package Mhj::CLI;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use Encode qw(encode decode);
use Data::Dumper;
use Getopt::Long;
use JSON::PP;

my ( $type, $method, $params ) = ( '', '', '{}' );
GetOptions(
    "type=s"   => \$type,
    "method=s" => \$method,
    "params=s" => \$params
) or die("Error in command line arguments\n");
my $options = +{
    type   => decode( 'UTF-8', $type ),
    method => decode( 'UTF-8', $method ),
    params => decode_json $params,
};
sub hello { print "hello CLI-----\n"; }

sub run {
    my ( $self, @args ) = @_;

    # 初期設定 / データベース設定更新 build
    return $self->build->run($options) if $options->{type} eq 'build';

    # 登録ユーザー
    return $self->user->run($options) if $options->{type} eq 'user';

    # 検索 search
    # 追加、更新
    return;
}

1;

__END__

type, method の付け方の参考
https://developers.google.com/blogger/docs/3.0/reference

データベースの初期設定
mhj --type=build --method=init
