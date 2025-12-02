#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day2');

my $solution = AoC::Solution::Day2->new(
    input => join('', q(
        11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
        1698522-1698528,446443-446449,38593856-38593862,565653-565659,
        824824821-824824827,2121212118-2121212124
    )),
);

is($solution->part_1, 1227775554, 'part_1');
is($solution->part_2, 4174379265, 'part_2');

done_testing();
