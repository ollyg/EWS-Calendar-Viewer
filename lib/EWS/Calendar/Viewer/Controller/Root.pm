package EWS::Calendar::Viewer::Controller::Root;
use strict;
use warnings;

use base 'Catalyst::Controller';
__PACKAGE__->config(namespace => '');

=head2 default

Detaches you to the calendar index if no other path is a match.

=cut

sub default : Private {
    my( $self, $c ) = @_;
    $c->detach( '/calendar/index' );
}

=head2 base

Simply adds basic data to the stash for some operations needed across various
methods.

=cut

sub base : Chained('/') PathPart('') CaptureArgs(0) {
    my( $self, $c )  = @_;
    $c->stash->{now} = DateTime->now->set( day => 1 );
    $c->stash->{version} = $EWS::Calendar::Viewer::VERSION;
    $c->stash->{privacy_level} = ($c->config->{privacy_level} || 'public');

    my @days = (qw/ Sunday Monday Tuesday Wednesday Thursday Friday Saturday /);
    my $sow = $c->config->{start_of_week};
    $c->stash->{days} = [ @days[$sow .. 6], @days[0 .. ($sow - 1)] ];
}

=head2 end

Renders a view if needed.

=cut

sub end : ActionClass('RenderView') {}

1;

