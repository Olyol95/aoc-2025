package AoC::Solution::Day8;

use v5.42;
use strictures 2;

use List::Util qw(product);
use Moo;

with 'AoC::Solution';

has iterations => (
    is      => 'ro',
    default => 1000,
);

sub part_1 {
    my $self = shift;

    my $distances = $self->input->{distances};
    my @closest   = sort { $a <=> $b } keys %$distances;

    my %circuits = %{ $self->input->{circuits} };
    for (1..$self->iterations) {
        my $distance = shift @closest;

        my ($a_id, $b_id) = @{ $distances->{$distance} };
        my $new_cid = $circuits{$a_id};
        my $old_cid = $circuits{$b_id};

        next if $new_cid == $old_cid;
        foreach my $j_id (keys %circuits) {
            my $c_id = $circuits{$j_id};
            $circuits{$j_id} = $new_cid if $c_id == $old_cid;
        }
    }

    my %totals;
    foreach my $j_id (keys %circuits) {
        my $c_id = $circuits{$j_id};
        $totals{$c_id}++;
    }

    my @values = sort { $b <=> $a } values %totals;
    return product @values[0..2];
}

sub part_2 {
    my $self = shift;

    my $distances = $self->input->{distances};
    my @closest   = sort { $a <=> $b } keys %$distances;

    my $answer;
    my %circuits = %{ $self->input->{circuits} };
    while (1) {
        my $distance = shift @closest;

        my ($a_id, $b_id) = @{ $distances->{$distance} };
        my $new_cid = $circuits{$a_id};
        my $old_cid = $circuits{$b_id};

        next if $new_cid == $old_cid;

        my %totals;
        foreach my $j_id (keys %circuits) {
            my $c_id = $circuits{$j_id};
            if ($c_id == $old_cid) {
                $circuits{$j_id} = $new_cid;
                $totals{$new_cid}++;
            }
            else {
                $totals{$c_id}++;
            }
        }

        if (scalar keys %totals == 1) {
            $answer = $self->input->{junctions}->{$a_id}->{x}
                * $self->input->{junctions}->{$b_id}->{x};
            last;
        }
    }

    return $answer;
}

sub _parse_input {
    my $self = shift;

    my %input;

    my $cid = 0;
    foreach my $line (split("\n", $self->input)) {
        chomp $line;
        $line =~ s/^\s+//g;
        next unless $line;
        my ($x, $y, $z) = split(/,/, $line);
        $input{junctions}->{$cid} = {
            x => $x,
            y => $y,
            z => $z,
        };
        $input{circuits}->{$cid} = $cid;
        $cid++;
    }

    my $total_junctions = scalar keys %{ $input{junctions} };
    foreach my $a_id (0..$total_junctions - 2) {
        foreach my $b_id ($a_id + 1..$total_junctions - 1) {
            my $distance = _distance(
                $input{junctions}->{$a_id},
                $input{junctions}->{$b_id},
            );
            $input{distances}->{$distance} = [$a_id, $b_id];
        }
    }

    return \%input;
}

sub _distance {
    my ($a, $b) = @_;

    return sqrt(
        ($b->{x} - $a->{x}) ** 2
            + ($b->{y} - $a->{y}) ** 2
            + ($b->{z} - $a->{z}) ** 2
    );
}

1;
