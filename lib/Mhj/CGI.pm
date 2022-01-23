package Mhj::CGI;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use Encode qw(encode decode);
use Data::Dumper;
use CGI;
use JSON::PP;

sub run {
    my ( $self, @args ) = @_;

    # 環境変数などにしておきたい
    my $apikey = "becom";

    # Resource types
    my $q = CGI->new;
    print $q->header( -type => 'application/json', -charset => 'utf-8' );
    my $params = decode_json $q->param('POSTDATA');

    # エラー判定
    return print encode_json $self->_error_msg
      if !$params->{type} || !$params->{method} || !$params->{apikey};
    return print encode_json $self->_error_msg if $params->{apikey} ne $apikey;

    # ルーティング
    return $self->build->run($params) if $params->{type} eq 'build';
    return $self->user->run($params)  if $params->{type} eq 'user';
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

{
  "error": {
    "code": 403, http ステータス
    "message": "The app with id {appId} " エラーメッセージ
  }
}
