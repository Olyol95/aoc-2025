#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day3');

my $solution = AoC::Solution::Day3->new(
    input => join("\n", q(
        987654321111111
        811111111111119
        234234234234278
        818181911112111
    )),
);

is($solution->part_1, 357, 'part_1');
is($solution->part_2, 3121910778619, 'part_2');

done_testing();
