package EWS::Calendar::Viewer::View::TT;

use strict;
use warnings FATAL => 'all';

use base qw( Catalyst::View::TT );
use File::ShareDir ();
use Try::Tiny;

__PACKAGE__->config({
    INCLUDE_PATH => [
        try {
            File::ShareDir::dist_dir('EWS-Calendar-Viewer')
        } catch {
            './share'
        }
    ],
    WRAPPER => 'wrapper.tt'
});

1;
