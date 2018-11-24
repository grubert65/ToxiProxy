use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy');
    use_ok('ToxiProxy::ServerMock');
}

ok( my $sm = ToxiProxy::ServerMock->new(), 'got a ToxiProxy::ServerMock obj');
ok( my $t = ToxiProxy->new(), 'new');
ok( $t->client->ua( $sm->get_ua()), 'get_ua');
ok( my $proxies = $t->get_proxies(), 'get_proxies');
is( $proxies->{p1}->{name}, 'p1', 'got right data back');

done_testing;
