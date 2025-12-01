package AoC::Solution::Day1;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my ($total, $answer) = (50, 0);
    foreach my $instr (@{ $self->input }) {
        ($total, my $zeroes) = turn_dial($total, $instr);
        $answer++ if $total == 0;
    }

    return $answer;
}

sub part_2 {
    my $self = shift;

    my ($total, $answer) = (50, 0);
    foreach my $instr (@{ $self->input }) {
        ($total, my $zeroes) = turn_dial($total, $instr);
        $answer += $zeroes;
    }

    return $answer;
}

sub turn_dial {
    my ($start, $instr) = @_;

    my ($total, $zeroes) = ($start, 0);
    foreach my $tick (1..$instr->{amount}) {
        if ($instr->{dir} eq 'L') {
            $total = ($total - 1) % 100;
        }
        else {
            $total = ($total + 1) % 100;
        }
        $zeroes++ if $total == 0;
    }

    return ($total, $zeroes);
}

sub _parse_input {
    my $self = shift;

    my @input;
    foreach my $line (split("\n", $self->input)) {
        next unless $line =~ /(L|R)(\d+)/;
        push @input, {
            dir    => $1,
            amount => $2,
        };
    }

    return \@input;
}

1;
