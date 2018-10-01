package ToxiProxy;
use Moose;
use RestAPI;

has 'host' => ( is => 'rw' );
has 'port' => ( is => 'rw', isa => 'Int' );


#============================================================= -*-perl-*-

=head1 NAME

ToxiProxy - The great new ToxiProxy!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use ToxiProxy;
    
    # get a toxiproxy client, it will
    # use defaults for host and port
    # (localhost, 8474)
    my $client = ToxiProxy->new();

    # or 
    my $client = ToxiProxy->new(
        host    => $host,
        port    => $port
    );

    # Returns the list of existing proxies and their toxics
    my $proxies = $client->get_proxies();

    # create the passed ToxiProxy::Proxy object on the server
    $client->create_proxy($proxy);

    # Create or replace a list of proxy objects
    $client->populate([p1, p2]);

    # Show the proxy with all its active toxics
    my $proxy = $client->get_proxy($proxy_name)                 : 

    # Update a proxy's fields
    $client->update_proxy($proxy);

    # deletes a proxy
    $client->delete_proxy( $proxy_name );

    # gets the list of active toxics
    my $toxics = $client->get_toxics( $proxy_name );

    # Create a new toxic
    $client->add_toxic($proxy, $toxic);

    # Get an active toxic's fields
    my $toxic = $client->get_toxic($proxy_name, $toxic_name);

    # Update an active toxic
    $client->update_toxic( $proxy_name, $toxic); 

    # Remove an active toxic
    $client->delete_toxic( $proxy_name, $toxic_name );

    # Enable all proxies and remove all active toxics
    $client->reset();

    # Returns the server version number
    my $version = $client->version();


=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head1 AUTHOR

Marco Masetti, C<< <marco.masetti at sky.uk> >>


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ToxiProxy


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Marco Masetti.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See perldoc perlartistic.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

#========================================================================
