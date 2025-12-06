#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day5');

my $solution = AoC::Solution::Day5->new(
    input => join("\n", q(
        3-5
        10-14
        16-20
        12-18

        1
        5
        8
        11
        17
        32
    )),
);

is($solution->part_1, 3, 'part_1');
is($solution->part_2, 14, 'part_2');

done_testing();
