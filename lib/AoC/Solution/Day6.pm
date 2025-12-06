package AoC::Solution::Day6;

use v5.42;
use strictures 2;

use List::Util qw(reduce);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $problem (@{ $self->input }) {
        $total += reduce {
            $problem->{operation}->($a, $b)
        } @{ $problem->{values}->{part_1} };
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $problem (@{ $self->input }) {
        $total += reduce {
            $problem->{operation}->($a, $b)
        } @{ $problem->{values}->{part_2} };
    }

    return $total;
}

sub _parse_input {
    my $self = shift;

    my @lines;
    foreach my $line (split("\n", $self->input)) {
        chomp $line;
        push @lines, $line if $line !~ /^\s*$/;
    }

    my @problems;

    my ($problem_id, $problem_chars) = (0, 0);
    foreach my $char (split(//, delete $lines[-1])) {
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

    my $line_number = 0;
    foreach my $line (@lines) {
        my ($problem_id, $char_id) = (0, 0);
        foreach my $char (split(//, $line)) {
            if ($char ne ' ') {
                $problems[$problem_id]{values}->{part_1}[$line_number] .= $char;
                $problems[$problem_id]{values}->{part_2}[$char_id] .= $char;
                $char_id++;
            }
            elsif ($char_id == $problems[$problem_id]{chars}) {
                $problem_id++;
                $char_id = 0;
            }
            else {
                $char_id++;
            }
        }
        $line_number++;
    }

    return \@problems;
}

1;
