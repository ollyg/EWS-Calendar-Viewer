package EWS::Calendar::Viewer;

use strict;
use warnings FATAL => 'all';

use MRO::Compat;
use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

# skip s3krits from dumped data
sub dump_these {
    my $c = shift;
    my @variables = $c->next::method(@_);
    return grep { $_->[0] !~ m/^(?:Config|Response|Stash)$/ } @variables;
}

__PACKAGE__->config({
    name => 'EWS::Calendar::Viewer',
});

__PACKAGE__->setup;

1;
__END__

# ABSTRACT: Share your MS Exchange Calendar via a Web Page

=head1 SYNOPSIS

I recommend you use something like L<App::BundleDeps> to deploy this under a
fastcgi server environment. Configure the application like so:

 privacy_level = limited
 start_of_week = 1
 
 <Model::EWSClient>
     <args>
         server   = myserver.example.com
         username = oliver
     </args>
 </Model::EWSClient>

And then start the Catalyst applicaton, perhaps using one of the bundled
server scripts.

=head1 CONFIGURTATION

=head2 privacy_level

This can be set to C<public> to show only your free/busy status, C<limited> to
show the title of the event as well, or C<private> to show all details of the
event in a tooltip.

=head2 start_of_week

Set this to a number from 0 to 6 representing Sunday through to Saturday
respectively.

=head2 EWS Client

You'll need to set the server fully qualified domain name, and username for
the calendar's account. The password can be set in the file using the
C<password> option or via the environment variable C<EWS_PASS>.

=cut
