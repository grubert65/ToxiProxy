package ToxiProxy::ServerMock;
#===============================================================================

=head1 NAME

ToxiProxy::ServerMock - a mocked toxiproxy server used to the ToxiProxy

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use ...;

=head1 EXPORT

None

=head1 AUTHOR

Marco Masetti, C<< <marco.masetti at softeco.it> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mir at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Mir>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ...


=head1 LICENSE AND COPYRIGHT

Copyright 2015 Marco Masetti.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

=head1 SUBROUTINES/METHODS

=cut

#===============================================================================
use v5.14;
use Moose;
use Test::LWP::UserAgent;
use JSON::XS;

our $coder = JSON::XS   ->new
                        ->utf8
                        ->allow_nonref
                        ->convert_blessed;

sub get_ua {
    my $self = shift;

    my $ua = Test::LWP::UserAgent->new();

    # GET /proxies
    $ua->map_response( 
        HTTP::Request->new( 'GET', 'http://localhost:8474/proxies' ),
        HTTP::Response->new('200','Success', 
            ['Content-Type' => 'application/json'],
            encode_json({
              "p1"=> {
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \1,
                "toxics"=> []
              }
          })
    ));

    # POST /proxies
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'POST' && $r->uri =~ m|proxies|;
        },
        HTTP::Response->new('201','Created', 
            ['Content-Type' => 'application/json'],
            encode_json({
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \1,
                "toxics"=> []
          })
    ));

    return $ua;
}

1; 
 

