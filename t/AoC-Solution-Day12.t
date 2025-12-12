#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day12');

my $solution = AoC::Solution::Day12->new(
    input => q(
        0:
        ###
        ##.
        ##.

        1:
        ###
        ##.
        .##

        2:
        .##
        ###
        ##.

        3:
        ##.
        ###
        ##.

        4:
        ###
        #..
        ###

        5:
        ###
        .#.
        ###

        4x4: 0 0 0 0 2 0
        12x5: 1 0 1 0 2 2
        12x5: 1 0 1 0 3 2
    ),
);

is($solution->part_1, 1, 'part_1');

done_testing();
