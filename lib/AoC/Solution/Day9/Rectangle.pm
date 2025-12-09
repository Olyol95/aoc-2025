package AoC::Solution::Day9::Rectangle;

use v5.42;
use strictures 2;

use List::Util qw(min max);
use Moo;

use AoC::Solution::Day9::Line;

has vertices => (
    is => 'ro',
    required => 1,
);

around BUILDARGS => sub {
    my ($orig, $class, $a, $b) = @_;

    return $class->$orig(
        vertices => [
            { x => min($a->{x}, $b->{x}), y => min($a->{y}, $b->{y}) },
            { x => max($a->{x}, $b->{x}), y => min($a->{y}, $b->{y}) },
            { x => max($a->{x}, $b->{x}), y => max($a->{y}, $b->{y}) },
            { x => min($a->{x}, $b->{x}), y => max($a->{y}, $b->{y}) },
        ],
    );
};

sub perimeter {
    my $self = shift;

    my @perimeter;
    my @vertices = (@{ $self->vertices }, $self->vertices->[0]);
    foreach my $idx (0 .. $#vertices - 1) {
        my @points = @{
            AoC::Solution::Day9::Line->new(
                $vertices[$idx], $vertices[$idx+1]
            )->points
        };
        push @perimeter, @points[0..$#points-1]
    }
    return \@perimeter;
}

sub area {
    my $self = shift;

    my ($a, $b) = (
        $self->vertices->[0],
        $self->vertices->[2]
    );

    return (($b->{x} - $a->{x}) + 1)
        * (($b->{y} - $a->{y}) + 1);
}

1;
