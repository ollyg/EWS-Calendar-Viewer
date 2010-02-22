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

__PACKAGE__->config({
    name => 'EWS Calendar Viewer',
});

__PACKAGE__->setup;

1;
__END__
=head1 NAME

EWS::Calendar::Viewer - Web viewer for your MS Exchange calendar

=head1 VERSION

This document refers to version 0.01 of EWS::Calendar::Viewer

=head1 SYNOPSIS



Set up your Exchange Web Services client:

 use EWS::Client;
 use DateTime;
 
 my $ews = EWS::Client->new({
     server      => 'exchangeserver.example.com',
     username    => 'oliver',
     password    => 's3krit', # or set in $ENV{EWS_PASS}
 });

Then perform operations on the Exchange server:

 my $entries = $ews->calendar->retrieve({
     start => DateTime->now(),
     end   => DateTime->now->add( month => 1 ),
 });
 
 print "I retrieved ". $entries->count ." items\n";
 
 while ($entries->has_next) {
     print $entries->next->Subject, "\n";
 }

=head1 DESCRIPTION

This module acts as a client to the Microsoft Exchange Web Services API. From
here you can access calendar (and soon, contact) entries in a nicely
abstracted fashion. Query results are generally available in an iterator and
convenience methods exist to access the properties of each entry.

=head1 METHODS

=head2 CONSTRUCTOR

=head2 EWS::Client->new( \%arguments )

Instantiates a new EWS client. There won't be any connection to the server
until you call one of the calendar or contacts retrieval methods.

=over 4

=item C<server> => Fully Qualified Domain Name (required)

The host name of the Exchange server to which the module should connect.

=item C<username> => String (required)

The account username under which the module will connect to Exchange. This
value will be URI encoded by the module.

=item C<password> => String OR via C<$ENV{EWS_PASS}> (required)

The password of the account under which the module will connect to Exchange.
This value will be URI encoded by the module. You can also provide the
password via the C<EWS_PASS> environment variable.

=item C<schema_path> => String (optional)

A folder on your file system which contains the WSDL and two further Schema
files (messages, and types) which describe the Exchange 2007 Web Services SOAP
API. They are shipped with this module so your providing this is optional.

=back

=head2 COMPONENT METHODS

There exist separate components to access the calendar (and soon, contacts)
entries on the Exchange server, each bundled with this module but having its
own manual page. Each component is accessed through a method and follow the
links below to learn about the available features.

=head2 $ews->calendar()

Retrieves the L<EWS::Client::Calendar> object which allows search and
retrieval of calendar entries.

=head1 TODO

I might look at moving away from L<XML::Compile::SOAP>, which is truely the
most awesome of modules, but overkill for ths very small set of static calls.

There is currently no handling of time zone information whatsoever. I'm
waiting for my timezone to shift to UTC+1 in March before working on this, as
I don't really want to read the Exchange API docs. Patches are welcome if you
want to help out.

=head1 REQUIREMENTS

=over 4

=item * L<Moose>

=item * L<XML::Compile::SOAP>

=item * L<DateTime>

=item * L<DateTime::Format::ISO8601>

=item * L<HTML::Strip>

=item * L<URI::Escape>

=back

=head1 AUTHOR

Oliver Gorwits C<< <oliver.gorwits@oucs.ox.ac.uk> >>

=head1 COPYRIGHT & LICENSE

Copyright (c) Oliver Gorwits 2010.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
