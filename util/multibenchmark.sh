#!/bin/bash

set -euo pipefail

# --- main -----------------------------------------------------------------

main() {
  if (( $# < 1 )); then
    die "Usage: $0 <tag name> [# of runs (default 4; must be multiple of nprocs)]"
  fi

  local -r tag="$1"
  local -r nruns="${2:-4}"
  if (( nruns < 1 )); then
    die "Number of runs must be positive"
  fi

  local -r stem="${tag}-$(date +'%F-%H%M%S')"
  local -r logfn="$stem.log"
  echo "# $tag ($stem) ($logfn)" > "$logfn"

  # Run the benchmarks
  set -x
  local i
  for i in `seq 0 $((nruns - 1))` ; do
    ./util/benchmark.py --generate-baseline -l wren \
        --baseline-filename "$stem-$i.txt"
  done 2>&1 |tee -a "$logfn"

  # Aggregate the data

  local fns=()
  declare -p fns
  for i in `seq 0 $((nruns - 1))` ; do  # can't do this in the loop above
    fns+=("$stem-$i.txt")               # because the loop body is a subshell
  done

  perl -M5.024 -Mvars='$results' -Mstrict -Mwarnings -F, -E '
    chomp @F; push $results->{$F[0]}->@*, $F[1];
    END { say join(q(,), qq("\Q$_\E"), $results->{$_}->@*) foreach sort keys %$results}' \
      "${fns[@]}" > "$stem-summary.csv"

  set +x
} #main()

# --- Helpers --------------------------------------------------------------

die() {
  printf "%s " 'Error:' "$@" 1>&2
  echo 1>&2
  exit 1
}

# --- Run it! --------------------------------------------------------------
main "$@"

# vi: set ts=2 sts=2 sw=2 et ai: #
