#!/usr/bin/env perl
use strict;
use warnings;
use ToxiProxy ();
# use Log::Log4perl qw(:easy);
# Log::Log4perl->easy_init($DEBUG);
print "Toxiproxy version: ".ToxiProxy->new()->version()."\n";

