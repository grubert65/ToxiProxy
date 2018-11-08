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
ok( my $toxic = $t->get_toxic('p1', 't1'), 'get_toxic');
is( ref $toxic, 'HASH', 'got right data type back' );
is( $toxic->{name}, "toxic-1", 'got right data back' );

done_testing;
