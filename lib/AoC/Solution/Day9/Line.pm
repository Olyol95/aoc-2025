package AoC::Solution::Day9::Line;

use v5.42;
use strictures 2;

use List::Util qw(min max);
use Moo;

has start => (
    is       => 'ro',
    required => 1,
);

has end => (
    is       => 'ro',
    required => 1,
);

around BUILDARGS => sub {
    my ($orig, $class, $a, $b) = @_;

    return $class->$orig(
        start => $a,
        end   => $b,
    );
};

sub points {
    my $self = shift;

    my $start = $self->start;
    my $end   = $self->end;

    my @points;
    foreach my $x (min($start->{x}, $end->{x}) .. max($start->{x}, $end->{x})) {
        foreach my $y (min($start->{y}, $end->{y}) .. max($start->{y}, $end->{y})) {
            push @points, { x => $x, y => $y };
        }
    }

    if ($start->{x} > $end->{x} || $start->{y} > $end->{y}) {
        @points = reverse @points;
    }

    return \@points;
}

1;
