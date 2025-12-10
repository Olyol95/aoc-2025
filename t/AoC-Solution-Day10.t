#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day10');

my $solution = AoC::Solution::Day10->new(
    input => join("\n",
        "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}",
        "[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}",
        "[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}",
    ),
);

is($solution->part_1, 7, 'part_1');

done_testing();
