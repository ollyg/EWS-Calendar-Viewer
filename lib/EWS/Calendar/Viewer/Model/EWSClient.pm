package EWS::Calendar::Viewer::Model::EWSClient;
BEGIN {
  $EWS::Calendar::Viewer::Model::EWSClient::VERSION = '1.111971';
}

use strict;
use warnings FATAL => 'all';

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config({
    class => 'EWS::Client',
});

1;
