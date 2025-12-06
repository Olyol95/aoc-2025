package AoC::Solution::Day5;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $id (@{ $self->input->{ids} }) {
        $total++ if $self->is_fresh($id);
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $range (@{ $self->input->{ranges} }) {
        $total += 1 + $range->{end} - $range->{start};
    }

    return $total;
}

sub is_fresh {
    my ($self, $id) = @_;

    foreach my $range (@{ $self->input->{ranges} }) {
        return 1 if $id >= $range->{start} && $id <= $range->{end};
    }

    return 0;
}

sub merge_ranges {
    my $ranges = shift;

    $ranges = [ sort { $a->{start} <=> $b->{start} } @$ranges ];

    my @merged;
    INPUT: foreach my $input (@$ranges) {
        foreach my $output (@merged) {
            # range is a sub-set
            if ($input->{end} <= $output->{end}) {
                next INPUT;
            }
            # right overlap
            elsif ($input->{start} <= $output->{end}) {
                $output->{end} = $input->{end};
                next INPUT;
            }
        }
        push @merged, $input;
    }

    return \@merged;
}

sub _parse_input {
    my $self = shift;

    my $input = {
        ranges => [],
        ids    => [],
    };

    my @ranges;
    foreach my $line (split("\n", $self->input)) {
        if ($line =~ /(\d+)\-(\d+)/) {
            push @ranges, {
                start => $1,
                end   => $2,
            };
        }
        elsif ($line =~ /(\d+)/) {
            push @{ $input->{ids} }, $1;
        }
    }

    $input->{ranges} = merge_ranges(\@ranges);

    return $input;
}

1;
