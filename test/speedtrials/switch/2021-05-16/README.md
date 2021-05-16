# 2021-05-16

```
./util/make-tests.pl 10 50 1000 10000 3 test/speedtrials/switch/2021-05-16/
(set -euo pipefail ; set -x ; for i in {0..8} ; do unbuffer ./util/speedtrial.pl --cpu-secs 10 --csv test/speedtrials/switch/2021-05-16/summary-2021-05-16-182700.csv test/speedtrials/switch/2021-05-16/$(printf 't%04d' "$i") ; done) 2>&1 |tee -a test/speedtrials/switch/2021-05-16/results-`now`.txt
```
