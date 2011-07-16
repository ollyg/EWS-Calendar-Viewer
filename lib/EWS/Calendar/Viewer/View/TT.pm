package EWS::Calendar::Viewer::View::TT;
BEGIN {
  $EWS::Calendar::Viewer::View::TT::VERSION = '1.111970';
}

use strict;
use warnings FATAL => 'all';

use base qw( Catalyst::View::TT );

__PACKAGE__->config({
    WRAPPER => 'wrapper.tt'
});

1;
