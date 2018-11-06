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

# Using an array of ToxiProxy::Proxy objectes...
ok( my $proxies = [
    ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080',
    ), 
    ToxiProxy::Proxy->new(
        name    => 'p2',
        listen  => 'localhost:8091',
        upstream=> 'localhost:8081',
    ), 
], 'an array of proxies');
ok( my $created = $p->populate($proxies), 'populate');
is( ref $created, 'HASH', 'got right data type back' );
is( $created->{proxies}->[0]->{name}, $proxies->[0]->{name}, 'got right data back' );

# Using an array of hashes...
$proxies = [
  {
    "name"      => "p1",
    "listen"    => "127.0.0.1:22220",
    "upstream"  => "127.0.0.1:6379"
  },
  {
    "name"      => "p2",
    "listen"    => "127.0.0.1:24220",
    "upstream"  => "127.0.0.1:3306"
  }
];
ok( $created = $p->populate($proxies), 'populate');
is( ref $created, 'HASH', 'got right data type back' );
is( $created->{proxies}->[0]->{name}, $proxies->[0]->{name}, 'got right data back' );

done_testing;

