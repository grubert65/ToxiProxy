package ToxiProxy::Toxic;
use Moo;
use Types::Standard qw( Str Num HashRef );

has ['name', 'type'] => ( is => 'rw', isa => Str, required => 1 );
has 'stream'         => ( is => 'rw', isa => Str );
has 'toxicity'       => ( is => 'rw', isa => Num );
has 'attributes'     => ( is => 'rw', isa => HashRef );

sub BUILD {
    my $self = shift;

    if ( $self->{stream} && ( $self->{stream} ne 'downstream' && $self->{stream} ne 'upstream' ) ) {
        die "Error: stream must be either 'downstream' or 'upstream'\n";
    }
}

sub TO_JSON {
    my $self = shift;
    my %h;

    foreach ( qw( name type stream toxicity attributes ) ) {
        $h{ $_ } = $self->$_ if defined $self->$_;
    }
    return \%h;
}

1;

__END__

#============================================================= -*-perl-*-

=head1 NAME

ToxiProxy::Toxic - A toxic object

=head1 VERSION

0.0.1

=cut

our $VERSION='0.0.1';


=head1 SYNOPSIS

    use ToxiProxy::Toxic;

    my $t = ToxiProxy::Toxic->new(
        name        => 't1',
        type        => 'latency',
        stream      => 'upstream',
        toxicity    => 0.8,
        attributes  => { latency => 200 }
    );


=head1 DESCRIPTION

A toxiproxy toxic object with fields as described in:
L<https://github.com/shopify/toxiproxy#http-api>


=head1 AUTHOR

Marco Masetti (marco.masetti @ sky.uk )

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2018 Marco Masetti (marco.masetti at sky.uk). All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See perldoc perlartistic.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

#========================================================================
