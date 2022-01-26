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
    my $apikey = 'becom';

    # Resource types
    my $q      = CGI->new;
    my $origin = $ENV{HTTP_ORIGIN};
    print $q->header(
        -type                             => 'application/json',
        -charset                          => 'utf-8',
        -access_control_allow_origin      => $origin,
        -access_control_allow_headers     => 'content-type,X-Requested-With',
        -access_control_allow_methods     => 'GET,POST,OPTIONS',
        -access_control_allow_credentials => 'true',
    );
    my $params   = {};
    my $postdata = $q->param('POSTDATA');
    if ($postdata) {
        $params = decode_json $postdata;
    }

    # エラー判定
    return print encode_json $self->_error_msg
      if !$params->{path} || !$params->{method} || !$params->{apikey};
    return print encode_json $self->_error_msg if $apikey ne $params->{apikey};

    # ルーティング
    if ( $params->{path} eq 'build' ) {
        print encode_json $self->build->run($params);
        print "\n";
        return;
    }
    if ( $params->{path} eq 'user' ) {
        print encode_json $self->user->run($params);
        print "\n";
        return;
    }
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
