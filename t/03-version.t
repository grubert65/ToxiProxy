use strict;
use warnings;
use Test::More;
use Proc::Find qw( proc_exists );
use Log::Log4perl qw( :easy );

Log::Log4perl->easy_init($DEBUG);

BEGIN {
    use_ok('ToxiProxy');
}

SKIP: {
    skip "toxiproxy-server is not running", 2, unless proc_exists(name => 'toxiproxy-server');
    ok( my $o = ToxiProxy->new(), 'new' );
    ok( my $v = $o->version(), 'version');
    note "Version: $v";
}

done_testing;



