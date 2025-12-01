package AoC::Solution::Day1;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my ($total, $zeroes) = (50, 0);
    foreach my $instr (@{ $self->input }) {
        next unless $instr =~ /(L|R)(\d+)/;
        if ($1 eq 'L') {
            $total = ($total - $2) % 100;
        }
        else {
            $total = ($total + $2) % 100;
        }
        $zeroes++ if $total == 0;
    }

    return $zeroes;
}

sub part_2 {
    my $self = shift;

    my ($total, $zeroes) = (50, 0);
    foreach my $instr (@{ $self->input }) {
        next unless $instr =~ /(L|R)(\d+)/;
        foreach my $tick (1..$2) {
            if ($1 eq 'L') {
                $total = ($total - 1) % 100;
            }
            else {
                $total = ($total + 1) % 100;
            }
            $zeroes++ if $total == 0;
        }
    }

    return $zeroes;
}

1;
