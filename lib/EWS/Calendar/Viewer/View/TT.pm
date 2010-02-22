package EWS::Calendar::Viewer::View::TT;

use strict;
use warnings FATAL => 'all';

use base qw( Catalyst::View::TT );

__PACKAGE__->config({
    WRAPPER => 'wrapper.tt'
});

1;
