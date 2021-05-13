#!/usr/bin/env perl

=head1 NAME

speedtrial.pl - Compare speed of multiple Wren files

=head1 SYNOPSIS

  speedtrial.pl [OPTIONS] STEM

Runs all C<< <STEM>*.wren >> tests and reports the results.

=cut

use 5.006;
use strict;
use warnings;
use autodie;
use Benchmark qw(cmpthese timethese);
use Config;
use File::Spec;
use FindBin;
use Getopt::Long qw(GetOptionsFromArray :config gnu_getopt);
use Pod::Usage qw(pod2usage);

exit main(@ARGV);

### Tweak the benchmark to take child time into account #####################

# By default, Benchmark runs until _this process_ has taken 0.1 sec. of CPU
# time for each test.  Since the vast majority of the runtime is in the
# _child processes_ for these tests, the default benchmarks take a very
# long time to run!
#
# To fix that, wrap Benchmark::timeit() to count child-process time
# as part of this process.

BEGIN {
  my $orig_timeit = \&Benchmark::timeit;
  no warnings 'redefine';
  *Benchmark::timeit = sub {
    my $times = $orig_timeit->(@_);

    #my($r, $pu, $ps, $cu, $cs, $n) = @$times;

    $times->[1] += $times->[3];    # Move user time from children to parent
    $times->[3] = 0;
    $times->[2] += $times->[4];    # Move system time from children to parent
    $times->[4] = 0;

    return $times;
  }
} ## end BEGIN

### main ####################################################################

sub main {
  my %opts  = parse_args(@_);
  my @tests = <$opts{stem}*.wren>;
  die "Couldn't find any tests for $opts{stem}" unless @tests;

  # Find wren_test
  my $wren_test = find_wren_test();

  print join "\n", "Running using $wren_test:", @tests, '';

  my $starttime = time();
  $| = 1;

  my $results = timethese(
    -$opts{cpu_secs},
    +{
      map {
        (File::Spec->splitpath($_))[2] =>
          "print '.'; die 'test failed' if system q($wren_test), q($_)"
      } @tests
    }
  );
  my $duration = time() - $starttime;

  print("Ran for $duration seconds using $wren_test\n");
  cmpthese($results);    # detailed report

  report_csv($opts{csv}, $opts{stem}, $results) if $opts{csv};

  return 0;
} ## end sub main

sub parse_args {
  my %opts;

  # Easier syntax for checking whether optional args were provided.
  # Syntax thanks to http://www.perlmonks.org/?node_id=696592
  local *have = sub { return exists($opts{ $_[0] }); };

  GetOptionsFromArray(
    \@_,       \%opts,
    'usage|?', 'h|help', 'man',    # options we handle here
    'csv=s',   'cpu_secs|cpu-secs=s',
  ) or pod2usage(2);
  pod2usage(2) unless @_ == 1;
  $opts{stem} = shift;

  pod2usage(-verbose => 0, -exitval => 0) if have('usage');
  pod2usage(-verbose => 1, -exitval => 0) if have('h');
  pod2usage(-verbose => 2, -exitval => 0) if have('man');

  $opts{cpu_secs} ||= 4;    # default CPU time, in seconds, per test

  return %opts;
} ## end sub parse_args

### Helpers #################################################################

sub report_csv {
  my ($fn, $stem, $results) = @_;

  # CSV summary.  Thanks to Benchmark::cmpthese() for the math below.
  my $report = qq("$stem","@{[scalar localtime]}");
  for my $test (sort keys %$results) {
    $report .=
      qq(,"$test",)
      . $results->{$test}->iters /
      ($results->{$test}->elapsed + 0.000000000000001);
  } ## end for my $test (sort keys...)
  open my $fh, '>>', $fn;
  print $fh "$report\n";
  close $fh;
} ## end sub report_csv

sub find_wren_test {
  my ($vol, $dirs, $file) = File::Spec->splitpath($FindBin::Bin);
  my @dirs = File::Spec->splitdir($dirs);
  pop @dirs;
  push @dirs, 'bin';
  $dirs = File::Spec->catdir(@dirs);
  my $path = File::Spec->catpath($vol, $dirs, "wren_test$Config{exe_ext}");
  unless(-f $path && -x $path) {
    die
"Wren test program $path not found or not executable.\nPlease build Wren and try again.\n";
  }
  return $path;
} ## end sub find_wren_test

### Docs ####################################################################
__END__

=head1 OPTIONS

=head2 B<--cpu-secs> C<secs>

Run for C<secs> seconds of CPU time instead of the default.

=head2 B<--csv> C<file>

Append a summary of the results to C<file>.

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

=head2 Benchmark

Some code from L<Benchmark>, which is distributed under the same terms as Perl
itself and is used according to those terms.

=cut
