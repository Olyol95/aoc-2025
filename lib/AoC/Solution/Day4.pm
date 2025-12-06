package AoC::Solution::Day4;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return scalar @{ to_remove($self->input) };
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    my $grid  = $self->input;
    while (1) {
        my $rolls = to_remove($grid);
        last unless @$rolls;
        $total += @$rolls;
        delete $grid->{$_->{x}}->{$_->{y}} foreach @$rolls;
    }

    return $total;
}

sub to_remove {
    my $grid = shift;

    my @rolls;
    foreach my $x (keys %$grid) {
        my $col = $grid->{$x};
        foreach my $y (keys %$col) {
            if (neighbours($grid, $x, $y) < 4) {
                push @rolls, {
                    x => $x,
                    y => $y,
                };
            }
        }
    }

    return \@rolls;
}

sub neighbours {
    my ($grid, $x, $y) = @_;

    my $total = 0;
    foreach my $dx (-1 .. 1) {
        foreach my $dy (-1 .. 1) {
            next if $dx == 0 && $dy == 0;
            $total++ if $grid->{$x + $dx}->{$y + $dy};
        }
    }

    return $total;
}

sub _parse_input {
    my $self = shift;

    my %grid;

    my $y = 0;
    foreach my $line (split("\n", $self->input)) {
        $line =~ s/\s+//g;
        next unless $line;
        my $x = 0;
        foreach my $char (split(//, $line)) {
            $grid{$x}{$y} = 1 if $char eq '@';
            $x++;
        }
        $y++;
    }

    return \%grid;
}

1;
