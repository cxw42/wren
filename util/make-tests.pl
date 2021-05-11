#!/usr/bin/env perl

=head1 NAME

make-tests.pl - Make tests of switch vs. if/then

=head1 SYNOPSIS

  make-tests.pl <min size> <max size> <min iters> <max iters> <dimsize>

Makes C<dimsize^2> test cases, evenly spread on size (number of cases) and
iters (number of times through the loop).

=cut

use 5.006;
use strict;
use warnings;
use autodie;
use File::Spec;
use FindBin;
use Pod::Usage qw(pod2usage);

exit main(@ARGV);

### main ####################################################################

sub main {
  pod2usage(2) unless @_ == 5;
  my ($minsize, $maxsize, $miniter, $maxiter, $dimsize) = @_;
  my @sizes = map { int($minsize + ($maxsize - $minsize) * $_ / ($dimsize-1)) } 0..($dimsize-1);
  my @iters = map { int($miniter + ($maxiter - $miniter) * $_ / ($dimsize-1)) } 0..($dimsize-1);

  my @tests;
  my $testidx = 0;
  my $testpath = test_path();

  foreach my $iter (@iters) {
    foreach my $size (@sizes) {
      make_test($testidx++, $size, $iter, $testpath);
    }
  }
  return 0;
} #main()

sub make_test {
  my ($testidx, $size, $iter, $testpath) = @_;
  my $stem = sprintf("t%04d_s%05d_i%05d", $testidx, $size, $iter);
  make_switch_test(File::Spec->join($testpath, "${stem}_switch.wren"), $size, $iter);
  make_ifthen_test(File::Spec->join($testpath, "${stem}_ifthen.wren"), $size, $iter);
}

sub make_switch_test {
  my ($fn, $size, $iter) = @_;
  print STDERR "Making $fn\n";

  open my $fh, '>', $fn;
  print $fh <<EOT;
for(iter in 1..$iter) {
  var topic = "a" // can't possibly match
  switch(topic) {
EOT

  foreach my $case (1..$size) {
    print $fh "    \"$case\".part: Fiber.abort(\"matched $case\")\n"
  }

  print $fh <<EOT;
  } //switch
} //iter
EOT
  close $fh;
}

sub make_ifthen_test {
  my ($fn, $size, $iter) = @_;
  print STDERR "Making $fn\n";

  open my $fh, '>', $fn;
  print $fh <<EOT;
for(iter in 1..$iter) {
  var topic = "a" // can't possibly match
  if(false) { // so the loop below can be regular
EOT

  foreach my $case (1..$size) {
    print $fh <<EOT;
  } else if("$case".contains(topic)) {
    Fiber.abort("matched $case")
EOT
  }

  print $fh <<EOT;
  } //last endif
} //iter
EOT
  close $fh;
}

sub test_path {
  my ($vol, $dirs, $file) = File::Spec->splitpath($FindBin::Bin);
  my @dirs = File::Spec->splitdir($dirs);
  pop @dirs;
  push @dirs, qw(test speedtrials switch);
  $dirs = File::Spec->catdir(@dirs);
  my $path = File::Spec->catdir($vol, $dirs);
  mkdir $path unless -d $path;
  return $path;
} #test_path

### Docs ####################################################################

=head1 AUTHOR

Christopher White (C<< cxwembedded@gmail.com >>)

=head1 LICENSE

MIT License

Copyright (c) 2021 Christopher White

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut
