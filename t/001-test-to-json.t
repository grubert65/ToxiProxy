use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy::Proxy');
    use_ok('ToxiProxy::Toxic');
}

ok( my $proxy = ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080',
        toxics  => [ ToxiProxy::Toxic->new(
                name        => 'toxic1',
                type        => 'type1',
                stream      => 'upstream',
                toxicity    => 1,
                attributes  => {delay => '100ms'}
            )
        ],
    ), 'new');

ok( my $json = $proxy->TO_JSON, 'TO_JSON');
is( ref $json, 'HASH', 'got right data type back');

done_testing;

