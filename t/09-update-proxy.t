use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy');
    use_ok('ToxiProxy::ServerMock');
}

ok( my $p = ToxiProxy->new(), 'new');
ok( my $sm = ToxiProxy::ServerMock->new(), 'got a ToxiProxy::ServerMock obj');
ok( $p->client->ua( $sm->get_ua()), 'get_ua');
ok( my $proxy = ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080',
        enabled => \1
    ), 'new');
ok( my $created = $p->create_proxy($proxy), 'create_proxies');

ok( my $updated = $p->update_proxy( 'p1', {enabled => \0} ), 'update_proxy' );
is( $updated->{enabled}, 0, 'proxy correctly updated' );
done_testing;

