package AoC::Solution::Day11;

use v5.42;
use strictures 2;

use Memoize;
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_routes_to_out_from('you');
}

sub part_2 {
    my $self = shift;

    return $self->_routes_to_out_via_dac_fft_from('svr');
}

sub _routes_to_out_from {
    my ($self, $node) = @_;

    my $paths = 0;
    foreach my $child (@{ $self->input->{$node} }) {
        if ($child eq 'out') {
            $paths++;
        }
        else {
            $paths+= $self->_routes_to_out_from($child);
        }
    }

    return $paths;
}

memoize('_routes_to_out_via_dac_fft_from');
sub _routes_to_out_via_dac_fft_from {
    my ($self, $node, %seen) = @_;

    my $paths = 0;
    foreach my $child (@{ $self->input->{$node} }) {
        if ($child eq 'out') {
            $paths++ if $seen{dac} && $seen{fft};
        }
        else {
            $paths += $self->_routes_to_out_via_dac_fft_from(
                $child,
                dac => $seen{dac} || $node eq 'dac',
                fft => $seen{fft} || $node eq 'fft',
            );
        }
    }

    return $paths;
}

sub _parse_input {
    my $self = shift;

    my %input;
    foreach my $line (split("\n", $self->input)) {
        next unless $line =~ /(\w+): ([\w\s]+)/;
        $input{$1} = [ split(/ /, $2) ];
    }

    return \%input;
}

1;
