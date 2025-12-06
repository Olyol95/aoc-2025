# https://metacpan.org/pod/distribution/Module-CPANfile/lib/cpanfile.pod

requires 'perl', 'v5.42';
requires 'Moo::Role';
requires 'strictures', '2';
requires 'Carp';
requires 'File::Slurp';
requires 'Getopt::Long';
requires 'List::Util';
requires 'Module::Load';
requires 'Pod::Usage';

on test => sub {
    requires 'Test::More';
    requires 'Essentials::Test::Critic';
};
