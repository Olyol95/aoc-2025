package AoC::Solution::Day10;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $machine (@{ $self->input }) {
        $total += _min_indicator_presses(
            $machine,
            [ [ map { 0 } @{ $machine->{target} } ] ],
            0
        );
    }

    return $total;
}

sub _min_indicator_presses {
    my ($machine, $states, $presses) = @_;

    my @new_states;
    foreach my $state (@$states) {
        foreach my $button (@{ $machine->{buttons} }) {
            my @new_state = @$state;
            foreach my $idx (@$button) {
                $new_state[$idx] = ($new_state[$idx] + 1) % 2;
            }
            if (_is_target_state($machine, \@new_state)) {
                return $presses + 1;
            }
            push @new_states, \@new_state;
        }
    }

    return _min_indicator_presses($machine, \@new_states, $presses + 1);
}

sub _is_target_state {
    my ($machine, $state) = @_;

    foreach my $idx (0..scalar @$state - 1) {
        return 0 unless $machine->{target}->[$idx] == $state->[$idx];
    }

    return 1;
}

sub _parse_input {
    my $self = shift;

    my @input;
    foreach my $line (split("\n", $self->input)) {
        next unless $line =~ /\[([.#]+)\]((?: \([^)]+\))+) \{([^}]+)\}/;
        my $machine = {
            target   => [ map { $_ eq '#' ? 1 : 0 } split(//, $1) ],
            buttons  => [],
            joltages => [ split(',', $3) ],
        };
        foreach my $button (split(' ', $2)) {
            $button =~ s/[()]//g;
            push @{ $machine->{buttons} }, [ split(',', $button) ];
        }
        push @input, $machine;
    }

    return \@input;
}

1;
