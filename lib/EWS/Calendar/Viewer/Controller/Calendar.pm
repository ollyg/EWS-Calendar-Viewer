package EWS::Calendar::Viewer::Controller::Calendar;

use strict;
use warnings FATAL => 'all';

use base qw( Catalyst::Controller );

use DateTime;
use Calendar::Simple;
use File::stat;
use XML::Atom::SimpleFeed;
use POSIX qw(strftime);
use List::Util qw(max);
use HTTP::Date;
use DateTime;

sub base : Chained('/base') PathPart('') CaptureArgs(0) {}

sub index : Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    my $year  = $c->{stash}->{now}->year;
    my $month = $c->{stash}->{now}->month;

    $c->stash->{calendar} = calendar(
        $month, $year,
        $c->config->{start_of_week},
    );
    $c->stash->{entries} = $c->model('EWSReader')->retrieve({
        start => DateTime->new( year => $year, month => $month ),
        end   => DateTime->new( year => $year, month => (($month + 1) % 12) ),
    })->items;
    $c->stash->{retrieved} = DateTime->now();

    $c->stash->{template} = 'month.tt';
}

sub get_year : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $year ) = @_;

    $c->detach( '/calendar/index' ) unless $year =~ /^\d{4}$/;

    $c->res->redirect( $c->uri_for('/') )
        unless ( -d $c->path_to( 'root', $year ) );

    $c->stash->{year}     = $year;
    $c->stash->{calendar} = calendar( 12, $year );
}

sub year : Chained('get_year') PathPart('') Args(0) {
    my ($self, $c) = @_;
    $c->stash->{template} = 'month.tt';
}

sub rss : Chained('base') Args() {
    my ( $self, $c, $year ) = @_;
    $c->go('feed', [$year] );
}

sub feed : Chained('base') Args() {
    my ( $self, $c, $year ) = @_;
    $year ||= $c->stash->{now}->year;
    $c->detach( '/calendar/index' ) unless $year =~ /^\d{4}$/;
    $c->res->redirect( $c->uri_for('/') )
        unless ( -e $c->path_to( 'root', $year ) );

    $c->stash->{year} = $year;

    my @entry = reverse 1 .. 24;
    my %path = map { $_ => $c->path_to( 'root', $year, "$_.pod" ) } @entry;
    @entry = grep -e $path{ $_ }, @entry;
    
    # only keep the newest five entries
    splice @entry, (@entry > 5) ? 5 : scalar @entry; 
    
    my %stat = map { $_ => stat ''. $path{ $_ } } @entry;
    my $latest_mtime = max map { $_->mtime } values %stat;
    my $last_mod = time2str( $latest_mtime );

    $c->res->header( 'Last-Modified' => $last_mod );
    $c->res->header( 'ETag' => qq'"$last_mod"' );
    $c->res->content_type( 'application/atom+xml' );
    
    my $cond_date = $c->req->header( 'If-Modified-Since' );
    my $cond_etag = $c->req->header( 'If-None-Match' );
    if( $cond_date || $cond_etag ) {

        # if both headers are present, both must match
        my $do_send_304 = 1;
    $do_send_304 = (str2time($cond_date) >= $latest_mtime)
      if( $cond_date );
    $do_send_304 &&= ($cond_etag eq qq{"$last_mod"})
      if( $cond_etag );
    
        if( $do_send_304 ) {
            $c->res->status( 304 );
            return;
        }
    }
    
    my $feed = XML::Atom::SimpleFeed->new(
        title   => "Catalyst Advent Calendar $year",
        link    => $c->req->base,
        link    => { rel => 'self', href => $c->uri_for("/feed/$year") },
        id      => $c->uri_for("/feed/$year"),
        updated => format_date_w3cdtf( $latest_mtime || 0 ),
    );

    for my $day ( @entry ) {
        my $parser = CatalystAdvent::Pod->new();

        my $file = q{}. $path{$day};
        open my $fh, '<:utf8', $file or die "Failed to open $file: $!";
        $parser->parse_from_filehandle($fh);
        close $fh;
        
        my $e = $feed->add_entry(
            title    => { type => 'text', content => $parser->title },
            content  => { type => 'html', content => $parser->asString },
            author   => { name => $parser->author||'Catalyst', 
            email    => ($parser->email || 'catalyst@lists.scsys.co.uk') },
            link     => $c->uri_for( "/$year/$day" ),
            id       => $c->uri_for( "/$year/$day" ),
            published=> format_date_w3cdtf( $stat{ $day }->ctime ),
            updated  => format_date_w3cdtf( $stat{ $day }->mtime ),
        );
    }

    $c->res->body( $feed->as_string );
}

=head2 format_date_w3cdtf

Formats a date as an ISO8601 date string.

=cut

sub format_date_w3cdtf { strftime '%Y-%m-%dT%H:%M:%SZ', gmtime $_[0] }

1;

