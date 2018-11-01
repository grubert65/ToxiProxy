use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy');
}

ok( my $p = ToxiProxy->new(), 'new');
ok( my $proxies = $p->get_proxies(), 'get_proxies');

done_testing;
