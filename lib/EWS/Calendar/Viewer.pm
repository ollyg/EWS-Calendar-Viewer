package EWS::Calendar::Viewer;

use strict;
use warnings FATAL => 'all';

use Catalyst qw/
    -Debug
    Static::Simple
    Cache
/;
    #Unicode

our $VERSION = '0.01';
$VERSION = eval $VERSION; # numify for warning-free dev releases

__PACKAGE__->config(
    name => 'Exchange Calendar Viewer',
    'Plugin::Cache' => {
        backend => {
            class => 'Cache::FileCache',
            namespace => 'EWSCalendarViewer',
        },
    },
);

__PACKAGE__->setup;

1;
