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
ok( my $proxy = ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080',
        enabled => \1
    ), 'new');
ok( my $created = $t->create_proxy($proxy), 'create_proxies');
ok( my $p1 = $t->get_proxy('p1'), 'get_proxies');
is( $p1->{name}, $proxy->{name}, "got right data back");

done_testing;
