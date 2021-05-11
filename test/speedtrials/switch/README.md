# test/speedtrials/switch/README.md

Where `util/make-tests.pl` puts its output.

## 2021-10-05:

```
$ ./util/make-tests.pl 10 100 100 10000 5
$ (set -euo pipefail ; set -x ; for i in {0..24} ; do unbuffer ./util/speedtrial.pl test/speedtrials/switch/$(printf 't%04d' "$i") ; done) 2>&1 |tee test/speedtrials/switch/results-`now`.txt

TODO next: hoist the `"string".part` out of the switch and see how performance compares.
