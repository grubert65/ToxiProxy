package ToxiProxy;
our $VERSION = '0.01';
use Moo;
use Types::Standard qw( Str Int );
use RestAPI;
use Try::Tiny;
use Data::Printer;
use ToxiProxy::Proxy;

has 'host'      => ( is => 'rw', isa => Str, default => 'localhost' );
has 'port'      => ( is => 'rw', isa => Int, default => 8474 );
has 'client'    => ( is => 'ro', lazy => 1, builder => '_get_client' );

sub _get_client {
    my $self = shift;
    RestAPI->new(
        scheme   => 'http',
        server   => "$self->{host}:$self->{port}",
        encoding => 'application/json',
        timeout  => 1,
    );
}


# Returns the list of existing proxies and their toxics
# or undef in case of errors
sub get_proxies {
    my $self = shift;

    $self->client->http_verb('GET');
    $self->client->query('proxies');
    $self->client->payload( undef );
    my $data = $self->client->do();
    $data = [$data] unless ref $data eq 'ARRAY';
    # TODO : we should convert data into an array of Proxy...
    return $data;
}

# create the passed ToxiProxy::Proxy object on the server
# returns 1/undef in case of errors
sub create_proxy {
    my ($self, $proxy) = @_;

    $self->client->http_verb('POST');
    $self->client->query('proxies');
    $self->client->payload( $proxy );
    my $data = $self->client->do() or return undef;;
    return $data;
}

# Create or replace a list of proxy objects
sub populate {
    my ( $self, $proxies ) = @_;

    $self->client->http_verb('POST');
    $self->client->query('populate');
    $self->client->payload( $proxies );
    my $data = $self->client->do() or return undef;;
    return $data;
}

# Show the proxy with all its active toxics
sub get_proxy {
    my ( $self, $proxy_name ) = @_;

    $self->client->http_verb('GET');
    $self->client->query("proxies/$proxy_name");
    $self->client->payload( undef );
    # TODO : we should convert data into an array of Proxy...
    $self->client->do();
}

# Update a proxy's fields
sub update_proxy {
    my ( $self, $proxy ) = @_;
}

# deletes a proxy
sub delete_proxy {
    my ( $self, $proxy_name ) = @_;
}

# gets the list of active toxics
sub get_toxics {
    my ( $self, $proxy_name ) = @_;
}

# Create a new toxic
sub add_toxic {
    my ( $self, $proxy, $toxic ) = @_;
}

# Get an active toxic's fields
sub get_toxic {
    my ( $self, $proxy_name, $toxic_name) = @_;
}

# Update an active toxic
sub update_toxic {
    my ($self,  $proxy_name, $toxic) = @_;
}

# Remove an active toxic
sub delete_toxic {
    my ( $self, $proxy_name, $toxic_name ) = @_;
}

# Enable all proxies and remove all active toxics
sub reset {
    my $self = shift;
}

# Returns the server version number
sub version {
    my $self = shift;
    $self->client->query('version');
    return $self->client->do();
}

1;

__PACKAGE__->meta->make_immutable();

__END__

#============================================================= -*-perl-*-

=head1 NAME

ToxiProxy - The great new ToxiProxy!

=head1 VERSION

Version 0.01

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

None.


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
