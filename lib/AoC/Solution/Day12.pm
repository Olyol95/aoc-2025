package AoC::Solution::Day12;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $region (@{ $self->input }) {
        my $size = $region->{height} * $region->{width};
        my $total_area = 9 * $region->{shapes};
        $total++ if $size >= $total_area;
    }

    return $total;
}

sub _parse_input {
    my $self = shift;

    my @input;
    foreach my $line (split("\n", $self->input)) {
        if ($line =~ /(\d+)x(\d+): ([\d\s]+)/) {
            my %region = (
                height => $2,
                width  => $1,
                shapes => 0,
            );
            foreach my $quantity (split(/ /, $3)) {
                $region{shapes}+= $quantity;
            }
            push @input, \%region;
        }
    }

    return \@input;
}

1;
