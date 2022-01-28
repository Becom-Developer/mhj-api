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
    warn Dumper($q);
    my $origin = $ENV{HTTP_ORIGIN};
    print $q->header(
        -type                             => 'application/json',
        -charset                          => 'utf-8',
        -access_control_allow_origin      => $origin,
        -access_control_allow_headers     => 'content-type,X-Requested-With',
        -access_control_allow_methods     => 'GET,POST,OPTIONS',
        -access_control_allow_credentials => 'true',
    );
    warn '-------1';
    # my $params   = {};
    # my $postdata = $q->param('POSTDATA');
    # if ($postdata) {
    #     warn '-------2';
    #     $params = decode_json $postdata;
    # }
    # warn '-------3';
    # warn Dumper($params);
    # warn Dumper($postdata);
    # # エラー判定
    # return $self->error->output(
    #     "Unknown option specification: path & method & apikey")
    #   if !$params->{path} || !$params->{method} || !$params->{apikey};
    # return $self->error->output("apikey is incorrect: $params->{apikey}")
    #   if $apikey ne $params->{apikey};

    # # ルーティング
    # if ( $params->{path} eq 'build' ) {
    #     print encode_json $self->build->run($params);
    #     print "\n";
    #     return;
    # }
    # if ( $params->{path} eq 'user' ) {
    #     print encode_json $self->user->run($params);
    #     print "\n";
    #     return;
    # }
    # return $self->error->output(
    #     "The path is specified incorrectly: $params->{path}");
    return;
}

1;

__END__
