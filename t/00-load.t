#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 1;
BEGIN {
    $ENV{EWS_PASS} = 'EWS_TESTING_PASS';
    use_ok( 'EWS::Calendar::Viewer' );
}
