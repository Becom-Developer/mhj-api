package Mhj;
use strict;
use warnings;
use utf8;
use Mhj::Build;
use Mhj::User;
sub new   { return bless {}, shift; }
sub build { Mhj::Build->new; }
sub user { Mhj::User->new; }

1;

__END__
