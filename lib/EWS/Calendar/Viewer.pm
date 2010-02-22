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

use FindBin;
__PACKAGE__->config({
    'Plugin::ConfigLoader' => { file => "$FindBin::Bin/../viewer.conf" },
});

__PACKAGE__->setup;

1;
