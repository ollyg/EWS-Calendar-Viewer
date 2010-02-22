package EWS::Calendar::Viewer::Model::EWSClient;

use strict;
use warnings FATAL => 'all';

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config({
    class => 'EWS::Client',
});

1;
