#!/usr/bin/env perl

use strict;
use warnings;

use Data::Printer;
use FindBin;
use lib $FindBin::Bin . '/lib';

use AIGit;
my $repo = AIGit->new('/home/gbhat/repos/AlmostIsland');
my $response = $repo->build;

p $response;
