use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy');
    use_ok('ToxiProxy::Toxic');
    use_ok('ToxiProxy::ServerMock');
}

ok( my $p = ToxiProxy->new(), 'new');
ok( my $sm = ToxiProxy::ServerMock->new(), 'got a ToxiProxy::ServerMock obj');
ok( $p->client->ua( $sm->get_ua()), 'get_ua');
ok( my $toxic = $p->add_toxic('p1', ToxiProxy::Toxic->new(
        name    => 'toxic-1',
        type    => 'latency',
        stream  => 'downstream'
        )), 'add_toxic');
is( ref $toxic, 'HASH', 'got right data type back' );
is( $toxic->{name}, 'toxic-1', 'got right data back' );

done_testing;

