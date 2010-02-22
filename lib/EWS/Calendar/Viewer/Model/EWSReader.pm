package EWS::Calendar::Viewer::Model::EWSReader;

use strict;
use warnings FATAL => 'all';

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
    class => 'EWS::Calendar::Read',
    args => {
        schema_path => '/home/oliver/subversion/oliver/pub/cpan/libews-calendar-read-perl/trunk/share',
        username    => 'oliver',
        password    => $ENV{PASS},
        server      => 'nexus.ox.ac.uk',
    },
);

1;
