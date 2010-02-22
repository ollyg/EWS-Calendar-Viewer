package EWS::Calendar::Viewer;

use strict;
use warnings FATAL => 'all';

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    Cache
/;

our $VERSION = '0.01';
$VERSION = eval $VERSION; # numify for warning-free dev releases

__PACKAGE__->setup;

1;
