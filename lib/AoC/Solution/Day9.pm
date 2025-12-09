package AoC::Solution::Day9;

use v5.42;
use strictures 2;

use List::Util qw(min max);
use Moo;

use AoC::Solution::Day9::Line;
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

sub _vertices_in_polygon {
    my ($self, $rect) = @_;

    foreach my $point (@{ $rect->vertices }) {
        return 0 unless $self->_point_in_polygon($point);
    }

    return 1;
}

sub _perimeter_in_polygon {
    my ($self, $rect) = @_;

    foreach my $point (@{ $rect->perimeter }) {
        return 0 unless $self->_point_in_polygon($point);
    }

    return 1;
}

sub _point_in_polygon {
    my ($self, $point) = @_;

    my $limits = $self->_polygon_limits;

    my ($x, $y) = ($point->{x}, $point->{y});
    return $y >= $limits->{y_at_x}->{$x}->{min}
        && $y <= $limits->{y_at_x}->{$x}->{max}
        && $x >= $limits->{x_at_y}->{$y}->{min}
        && $x <= $limits->{x_at_y}->{$y}->{max};
}

sub _polygon_limits {
    my $self = shift;

    state $limits;

    unless ($limits) {
        my @vertices = (@{ $self->input }, $self->input->[0]);

        my $prev = shift @vertices;
        while (@vertices) {
            my $next = shift @vertices;
            my $line = AoC::Solution::Day9::Line->new($prev, $next);
            foreach my $point (@{ $line->points }) {
                my ($x, $y) = ($point->{x}, $point->{y});
                push @{ $limits->{y_at_x}->{$x} }, $y;
                push @{ $limits->{x_at_y}->{$y} }, $x;
            }
            $prev = $next;
        }

        foreach my $dim (qw(y_at_x x_at_y)) {
            foreach my $key (keys %{ $limits->{$dim} }) {
                $limits->{$dim}->{$key} = {
                    min => min(@{ $limits->{$dim}->{$key} }),
                    max => max(@{ $limits->{$dim}->{$key} }),
                };
            }
        }
    }

    return $limits;
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
