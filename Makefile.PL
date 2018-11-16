use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'ToxiProxy',
    AUTHOR           => q{Marco Masetti <marco.masetti@sky.uk>},
    VERSION_FROM     => 'lib/ToxiProxy.pm',
    ABSTRACT_FROM    => 'lib/ToxiProxy.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More'            => '0',
        'Proc::Find'            => 0,
        'Test::LWP::UserAgent'  => 0,
    },
    PREREQ_PM => {
        'JSON::XS'              => 0,
        'Moo'                   => 0,
        'Moose'                 => 0,
        'RestAPI'               => 0,
        'Types::Standard'       => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'ToxiProxy-*' },
);
