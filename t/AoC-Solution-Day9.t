#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day9');

my $solution = AoC::Solution::Day9->new(
    input => join("\n", q(
        7,1
        11,1
        11,7
        9,7
        9,5
        2,5
        2,3
        7,3
    )),
);

is($solution->part_1, 50, 'part_1');
is($solution->part_2, 24, 'part_2');

done_testing();
