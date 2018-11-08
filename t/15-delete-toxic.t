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
ok( my $deleted = $p->delete_toxic( 'p1', 't1' ), 'delete_toxic' );
is( $deleted, 204, 'got right http code back');
done_testing;

