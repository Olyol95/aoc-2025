package AoC::Solution::Day9;

use v5.42;
use strictures 2;

use List::Util qw(min max);
use Moo;

use AoC::Solution::Day9::Rectangle;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my @vertices = @{ $self->input };

    my $max = 0;
    foreach my $a_idx (0..$#vertices-1) {
        foreach my $b_idx ($a_idx+1..$#vertices) {
            my $area = AoC::Solution::Day9::Rectangle->new(
                $vertices[$a_idx],
                $vertices[$b_idx],
            )->area;
            $max = $area if $area > $max;
        }
    }

    return $max;
}

sub part_2 {
    my $self = shift;

    my @vertices = @{ $self->input };

    my %areas;
    foreach my $a_idx (0..$#vertices-1) {
        foreach my $b_idx ($a_idx+1..$#vertices) {
            my $rect = AoC::Solution::Day9::Rectangle->new(
                $vertices[$a_idx],
                $vertices[$b_idx],
            );
            next unless $self->_vertices_in_polygon($rect);
            $areas{$rect->area} = $rect;
        }
    }

    foreach my $area (sort { $b <=> $a } keys %areas) {
        my $rect = $areas{$area};
        return $area if $self->_perimeter_in_polygon($rect);
    }
}

sub _polygon_limits {
    my $self = shift;

    state $limits;

    return $limits if $limits;

    my @vertices = @{ $self->input };
    push @vertices, $vertices[0];

    my $prev = shift @vertices;
    while (@vertices) {
        my $next = shift @vertices;
        if ($prev->{x} != $next->{x}) {
            foreach my $x (min($prev->{x}, $next->{x}) .. max($prev->{x}, $next->{x})) {
                push @{ $limits->{at_x}->{$x} }, $next->{y};
                push @{ $limits->{at_y}->{$next->{y}} }, $x;
            }
        }
        else {
            foreach my $y (min($prev->{y}, $next->{y}) .. max($prev->{y}, $next->{y})) {
                push @{ $limits->{at_x}->{$next->{x}} }, $y;
                push @{ $limits->{at_y}->{$y} }, $next->{x};
            }
        }
        $prev = $next;
    }

    foreach my $x (keys %{ $limits->{at_x} }) {
        $limits->{at_x}->{$x} = [
            min(@{ $limits->{at_x}->{$x} }),
            max(@{ $limits->{at_x}->{$x} }),
        ];
    }
    foreach my $y (keys %{ $limits->{at_y} }) {
        $limits->{at_y}->{$y} = [
            min(@{ $limits->{at_y}->{$y} }),
            max(@{ $limits->{at_y}->{$y} }),
        ];
    }

    return $limits;
}

sub _vertices_in_polygon {
    my ($self, $rect) = @_;

    my $limits = $self->_polygon_limits;

    foreach my $point (@{ $rect->vertices }) {
        my ($x, $y) = ($point->{x}, $point->{y});
        return 0 unless $y >= $limits->{at_x}->{$x}->[0]
            && $y <= $limits->{at_x}->{$x}->[1]
            && $x >= $limits->{at_y}->{$y}->[0]
            && $x <= $limits->{at_y}->{$y}->[1];
    }

    return 1;
}

sub _perimeter_in_polygon {
    my ($self, $rect) = @_;

    my $limits = $self->_polygon_limits;

    foreach my $point (@{ $rect->perimeter }) {
        my ($x, $y) = ($point->{x}, $point->{y});
        return 0 unless $y >= $limits->{at_x}->{$x}->[0]
            && $y <= $limits->{at_x}->{$x}->[1]
            && $x >= $limits->{at_y}->{$y}->[0]
            && $x <= $limits->{at_y}->{$y}->[1];
    }

    return 1;
}

sub _parse_input {
    my $self = shift;

    my @vertices;
    foreach my $line (split("\n", $self->input)) {
        next unless $line =~ /(\d+),(\d+)/;
        push @vertices, {
            x => $1,
            y => $2,
        };
    }

    return \@vertices;
}

1;
