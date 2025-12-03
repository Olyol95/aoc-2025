package AoC::Solution::Day3;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $output = 0;
    foreach my $bank (@{ $self->input }) {
        $output += max_joltage($bank, 2);
    }

    return $output;
}

sub part_2 {
    my $self = shift;

    my $output = 0;
    foreach my $bank (@{ $self->input }) {
        $output += max_joltage($bank, 12);
    }

    return $output;
}

sub max_joltage {
    my ($bank, $digits) = @_;

    my ($max, $max_idx) = (0, 0);
    foreach my $idx (0 .. @$bank - $digits) {
        my $value = $bank->[$idx];
        if ($value > $max) {
            $max = $value;
            $max_idx = $idx;
        }
    }

    if ($digits == 1) {
        return $max;
    }
    else {
        my @remainder = @$bank[$max_idx + 1 .. @$bank - 1];
        return $max . max_joltage(\@remainder, $digits - 1);
    }
}

sub _parse_input {
    my $self = shift;

    my @banks;
    foreach my $line (split("\n", $self->input)) {
        $line =~ s/\s+//g;
        next unless $line;
        push @banks, [ split(//, $line) ];
    }

    return \@banks;
}

1;
