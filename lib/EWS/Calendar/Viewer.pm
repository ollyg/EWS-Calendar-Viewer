package EWS::Calendar::Viewer;

use strict;
use warnings FATAL => 'all';

use MRO::Compat;
use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

our $VERSION = '0.01';
$VERSION = eval $VERSION; # numify for warning-free dev releases

# skip s3krits from dumped data
sub dump_these {
    my $c = shift;
    my @variables = $c->next::method(@_);
    return grep { $_->[0] !~ m/^(?:Config|Response|Stash)$/ } @variables;
}


__PACKAGE__->setup;

1;
