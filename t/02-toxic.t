use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('ToxiProxy::Toxic');
}

ok( my $p = ToxiProxy::Toxic->new(
        name    => 't1',
        type    => 'latency',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080'
    ), 'new');

done_testing;


