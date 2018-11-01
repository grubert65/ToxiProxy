use strict;
use warnings;
use Test::More;
use Log::Log4perl qw( :easy );

Log::Log4perl->easy_init($DEBUG);

BEGIN {
    use_ok('ToxiProxy');
}

ok( my $o = ToxiProxy->new(), 'new' );
ok( my $v = $o->version(), 'version');
note "Version: $v";

done_testing;



