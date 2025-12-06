#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day4');

my $solution = AoC::Solution::Day4->new(
    input => join("\n", q(
        ..@@.@@@@.
        @@@.@.@.@@
        @@@@@.@.@@
        @.@@@@..@.
        @@.@@@@.@@
        .@@@@@@@.@
        .@.@.@.@@@
        @.@@@.@@@@
        .@@@@@@@@.
        @.@.@@@.@.
    )),
);

is($solution->part_1, 13, 'part_1');
is($solution->part_2, 43, 'part_2');

done_testing();
