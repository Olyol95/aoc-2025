package AoC::Solution::Day7;

use v5.42;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->number_of_splits(
        $self->input->{start}, {}
    );
}

sub part_2 {
    my $self = shift;

    return $self->unique_paths(
        $self->input->{start}, {}
    ) + 1;
}

sub number_of_splits {
    my ($self, $start, $seen) = @_;

    my $splitters = $self->input->{splitters};

    my $splits = 0;
    my %loc = %$start;
    while ($loc{y} < $self->input->{height} - 2) {
        if ($splitters->{$loc{x}}{$loc{y}+1}) {
            my ($left, $right) = (
                { x => $loc{x} - 1, y => $loc{y} + 1 },
                { x => $loc{x} + 1, y => $loc{y} + 1 },
            );
            my $did_split = 0;
            foreach my $dir (($left, $right)) {
                my $key = _key($dir);
                unless ($seen->{$key}) {
                    $did_split = 1;
                    $seen->{$key} = 1;
                    $splits += $self->number_of_splits($dir, $seen);
                }
            }
            $splits++ if $did_split;
            last;
        }
        $loc{y}++;
    }

    return $splits;
}

sub unique_paths {
    my ($self, $start, $seen) = @_;

    my $splitters = $self->input->{splitters};

    my $paths = 0;
    my %loc = %$start;
    while ($loc{y} < $self->input->{height} - 2) {
        if ($splitters->{$loc{x}}{$loc{y}+1}) {
            my ($left, $right) = (
                { x => $loc{x} - 1, y => $loc{y} + 1 },
                { x => $loc{x} + 1, y => $loc{y} + 1 },
            );
            $paths++;
            foreach my $dir (($left, $right)) {
                my $key = _key($dir);
                my $cached = $seen->{$key};
                if ($cached) {
                    $paths += $cached;
                }
                else {
                    my $val = $self->unique_paths($dir, $seen);
                    $seen->{$key} = $val;
                    $paths += $val;
                }
            }
            last;
        }
        $loc{y}++;
    }

    return $paths;
}

sub _key {
    my $loc = shift;

    return join(',', $loc->{x}, $loc->{y});
}

sub _parse_input {
    my $self = shift;

    my %input;

    my $y = 0;
    foreach my $line (split("\n", $self->input)) {
        chomp $line;
        $line =~ s/^\s+//g;
        next unless $line;

        my $x = 0;
        foreach my $char (split(//, $line)) {
            if ($char eq 'S') {
                $input{start} = {
                    x => $x,
                    y => $y,
                };
            }
            elsif ($char eq '^') {
                $input{splitters}{$x}{$y} = 1;
            }
            $x++;
        }
        $input{width} = $x;
        $y++;
    }
    $input{height} = $y;

    return \%input;
}

1;
