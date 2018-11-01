use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy::Proxy');
}

ok( my $p = ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080'
    ), 'new');

done_testing;


