package AoC::Solution::Day6;

use v5.42;
use strictures 2;

use List::Util qw(reduce sum);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return sum map {
        reduce {
            $_->{operation}->($a, $b)
        } @{ $_->{values}->{part_1} }
    } @{ $self->input };
}

sub part_2 {
    my $self = shift;

    return sum map {
        reduce {
            $_->{operation}->($a, $b)
        } @{ $_->{values}->{part_2} }
    } @{ $self->input };
}

sub _parse_input {
    my $self = shift;

    my @lines = map { chomp; $_ } split ("\n", $self->input);

    my $problems = _parse_operations(delete $lines[-1]);

    foreach my $line_number (0..$#lines) {
        my ($problem_id, $char_idx) = (0, 0);
        foreach my $char (split(//, $lines[$line_number])) {
            if ($char_idx == $problems->[$problem_id]{chars}) {
                $problem_id++;
                $char_idx = 0;
                next;
            }
            if ($char ne ' ') {
                $problems->[$problem_id]{values}->{part_1}[$line_number] .= $char;
                $problems->[$problem_id]{values}->{part_2}[$char_idx] .= $char;
            }
            $char_idx++;
        }
        $line_number++;
    }

    return $problems;
}

sub _parse_operations {
    my $line = shift;

    my @problems;

    my ($problem_id, $problem_chars) = (0, 0);
    foreach my $char (split(//, $line)) {
        if ($char eq '+') {
            $problems[$problem_id]{operation} = sub {
                my ($a, $b) = @_;
                return $a + $b;
            };
        }
        elsif ($char eq '*') {
            $problems[$problem_id]{operation} = sub {
                my ($a, $b) = @_;
                return $a * $b;
            };
        }
        if ($char ne ' ') {
            $problems[$problem_id - 1]{chars} = $problem_chars - 1;
            $problem_id++;
            $problem_chars = 0;
        }
        $problem_chars++;
    }
    $problems[$problem_id - 1]{chars} = $problem_chars;

    return \@problems;
}

1;
