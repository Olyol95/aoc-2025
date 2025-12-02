package AoC::Solution::Day2;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $answer = 0;
    foreach my $range (@{ $self->input }) {
        foreach my $id ($range->{start} ... $range->{end}) {
            $answer += $id if $id =~ /^(\d+)\1$/;
        }
    }

    return $answer;
}

sub part_2 {
    my $self = shift;

    my $answer = 0;
    foreach my $range (@{ $self->input }) {
        foreach my $id ($range->{start} ... $range->{end}) {
            $answer += $id if $id =~ /^(\d+)\1+$/;
        }
    }

    return $answer;
}

sub _parse_input {
    my $self = shift;

    my $input = $self->input;
    chomp $input;

    my @ranges;
    foreach my $range (split(/,/, $input)) {
        my ($start, $end) = split(/-/, $range);
        push @ranges, {
            start => int $start,
            end   => int $end,
        };
    }

    return \@ranges;
}

1;
