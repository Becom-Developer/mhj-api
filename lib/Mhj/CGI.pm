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
    my $q       = CGI->new;
    my $origin  = $ENV{HTTP_ORIGIN};
    my @headers = (
        -type    => 'application/json',
        -charset => 'utf-8',
    );
    if ($origin) {
        @headers = (
            @headers,
            -access_control_allow_origin  => $origin,
            -access_control_allow_headers => 'content-type,X-Requested-With',
            -access_control_allow_methods => 'GET,POST,OPTIONS',
            -access_control_allow_credentials => 'true',
        );
    }
    print $q->header(@headers);
    my $params   = {};
    my $postdata = $q->param('POSTDATA');
    if ($postdata) {
        $params = decode_json $postdata;
    }

    # エラー判定
    return $self->error->output(
        "Unknown option specification: path & method & apikey")
      if !$params->{path} || !$params->{method} || !$params->{apikey};
    return $self->error->output("apikey is incorrect: $params->{apikey}")
      if $apikey ne $params->{apikey};

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
    return $self->error->output(
        "The path is specified incorrectly: $params->{path}");
}

1;

__END__
