use strict;
use warnings;
use Test::More;
use JSON::XS;

BEGIN {
    use_ok('ToxiProxy');
    use_ok('ToxiProxy::Proxy');
}

ok( my $proxy = ToxiProxy::Proxy->new(
        name    => 'p1',
        listen  => 'localhost:8090',
        upstream=> 'localhost:8080'
    ), 'new');

my $json = JSON::XS->new->allow_nonref->convert_blessed;
ok( my $payload = $json->encode( $proxy ), 'encode');
ok( my $h = decode_json( $payload ), 'payload decoded');
is( $h->{name}, 'p1', 'got right data decoded back' );

done_testing;

