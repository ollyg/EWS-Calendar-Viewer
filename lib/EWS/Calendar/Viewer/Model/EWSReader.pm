package EWS::Calendar::Viewer::Model::EWSReader;

use strict;
use warnings FATAL => 'all';

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config({
    class => 'EWS::Calendar::Read',
});

1;
