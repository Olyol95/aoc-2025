#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day11');

is(
    AoC::Solution::Day11->new(
        input => q(
            aaa: you hhh
            you: bbb ccc
            bbb: ddd eee
            ccc: ddd eee fff
            ddd: ggg
            eee: out
            fff: out
            ggg: out
            hhh: ccc fff iii
            iii: out
        ),
    )->part_1, 5, 'part_1'
);

is (
    AoC::Solution::Day11->new(
        input => q(
            svr: aaa bbb
            aaa: fft
            fft: ccc
            bbb: tty
            tty: ccc
            ccc: ddd eee
            ddd: hub
            hub: fff
            eee: dac
            dac: fff
            fff: ggg hhh
            ggg: out
            hhh: out
        )
    )->part_2, 2, 'part_2'
);

done_testing();
