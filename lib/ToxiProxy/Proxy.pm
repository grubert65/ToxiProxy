package ToxiProxy::Proxy;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'Fqdn',
    as      'Str',
    where   { $_ =~ /(localhost|((([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+([A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]*)))/ },
    message { "$_ is not a valid FQDN" };

has 'name'                   => ( is => 'rw', required => 1 );
has [ 'listen', 'upstream' ] => ( is => 'rw', isa => 'Fqdn', required => 1 );
has 'enabled'                => ( is => 'rw', isa => 'Int', default => 1 );
has 'toxics'                 => ( is => 'ro', isa => 'ArrayRef[ToxiProxy::Toxic]' );

1;

__END__


#===============================================================================

=head1 NAME

ToxiProxy::Proxy - A proxy object


=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use ToxiProxy::Proxy;

    try { 
        my $proxy = ToxiProxy::Proxy->new(
            name        => 'proxy1',
            listen      => 'localhost:8090',
            upstream    => 'localhost:8080',
            enabled     => 0    #defaults to true on creation
        );
    } catch {
        die "Error getting a Proxy object\n";
    }

=head1 EXPORT

None

=head1 AUTHOR

Marco Masetti, C<< <marco.masetti at softeco.it> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Toxiproxy::Proxy


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2018 Marco Masetti.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

#===============================================================================
