#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day1');

my $solution = AoC::Solution::Day1->new(
    input => join("\n", q(
        L68
        L30
        R48
        L5
        R60
        L55
        L1
        L99
        R14
        L82
    )),
);

is($solution->part_1, 3, 'part_1');
is($solution->part_2, 6, 'part_2');

done_testing();
