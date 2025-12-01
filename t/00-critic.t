#!/usr/bin/env perl

use v5.42;
use strictures 2;

use Essentials::Test::Critic;

Essentials::Test::Critic->new->all_ok('lib');
