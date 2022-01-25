package Mhj;
use strict;
use warnings;
use utf8;
use Time::Piece;
use Mhj::Build;
use Mhj::User;
sub new        { return bless {}, shift; }
sub build      { Mhj::Build->new; }
sub user       { Mhj::User->new; }
sub time_stamp { return localtime->datetime( 'T' => ' ' ); }

1;

__END__
