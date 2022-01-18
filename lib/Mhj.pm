package Mhj;
use strict;
use warnings;
use utf8;
use Mhj::Build;
sub new   { return bless {}, shift; }
sub build { Mhj::Build->new; }

1;

__END__
