#!/usr/bin/perl -w

BEGIN { 
    $ENV{CATALYST_ENGINE} ||= 'HTTP';
    $ENV{CATALYST_SCRIPT_GEN} = 23;
}  

use strict;
use Getopt::Long;
use Pod::Usage;
use FindBin;
use lib "$FindBin::Bin/../lib";

my $debug         = 0;
my $fork          = 0;
my $help          = 0;
my $host          = undef;
my $port          = 3000;
my $keepalive     = 0;
my $restart       = 0;
my $restart_delay = 1;
my $restart_regex = '\.yml$|\.yaml$|\.pm$';

my @argv = @ARGV;

GetOptions(
    'debug|d'           => \$debug,
    'fork'              => \$fork,
    'help|?'            => \$help,
    'host=s'            => \$host,
    'port=s'            => \$port,
    'keepalive|k'       => \$keepalive,
    'restart|r'         => \$restart,
    'restartdelay|rd=s' => \$restart_delay,
    'restartregex|rr=s' => \$restart_regex
);

pod2usage(1) if $help;

if ( $restart ) {
    $ENV{CATALYST_ENGINE} = 'HTTP::Restarter';
}
if ( $debug ) {
    $ENV{CATALYST_DEBUG} = 1;
}

# This is require instead of use so that the above environment
# variables can be set at runtime.
require EWS::Calendar::Viewer;

EWS::Calendar::Viewer->run( $port, $host, {
    argv          => \@argv,
    'fork'        => $fork,
    keepalive     => $keepalive,
    restart       => $restart,
    restart_delay => $restart_delay,
    restart_regex => qr/$restart_regex/
} );

1;
