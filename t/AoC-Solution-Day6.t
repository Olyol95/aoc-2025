#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day6');

my $solution = AoC::Solution::Day6->new(
    input => join("\n", q(
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
    )),
);

is($solution->part_1, 4277556, 'part_1');
is($solution->part_2, 3263827, 'part_2');

done_testing();
