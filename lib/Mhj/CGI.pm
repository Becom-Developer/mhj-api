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

    # オリジンの表
    my $origin_list = +{
        becom_1 => 'http://localhost:3000',
        becom_2 => 'https://mhj-api.becom.co.jp',
    };

    # Resource types
    my $q      = CGI->new;
    # my $params = decode_json $q->param('POSTDATA');
    # my $origin = $origin_list->{ $params->{apikey} };
    my $origin = 'http://localhost:3000';
    print $q->header(
        -type                             => 'application/json',
        -charset                          => 'utf-8',
        # -access_control_allow_origin      => 'http://localhost:3000',
        -access_control_allow_origin      => $origin,
        -access_control_allow_headers     => 'content-type,X-Requested-With',
        -access_control_allow_methods     => 'GET,POST,OPTIONS',
        -access_control_allow_credentials => 'true',
    );
    my $params = decode_json $q->param('POSTDATA');

    # エラー判定
    return print encode_json $self->_error_msg
      if !$params->{path} || !$params->{method} || !$params->{apikey};
    # return print encode_json $self->_error_msg if !$origin;

    # ルーティング
    return $self->build->run($params) if $params->{path} eq 'build';
    return $self->user->run($params)  if $params->{path} eq 'user';
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
