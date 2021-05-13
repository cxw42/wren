# wren/test/speedtrials/switch/2021-05-12/README.md

## How this was run

```
$ ./util/make-tests.pl 1 50 100 2000 5 test/speedtrials/switch/2021-05-12/
$ (set -euo pipefail ; set -x ; for i in {0..24} ; do unbuffer ./util/speedtrial.pl --csv test/speedtrials/switch/2021-05-12/summary-2021-05-12-220400.csv test/speedtrials/switch/2021-05-12/$(printf 't%04d' "$i") ; done) 2>&1 |tee test/speedtrials/switch/2021-05-12/log-2021-05-12-220620.txt
```

(`unbuffer` is from the `expect` package)

## Tests

Test names are:

```
t0024_s00050_i02000_switch.wren
                    ^^^^^^--- which technique
              ^^^^^--- how many loop iterations
       ^^^^^--- how many cases (_s_ize)
 ^^^^--- test number (0..24)
```

Test techniques are:
- `switch`: switch with smartmatch, with `"foo".part` in each test
- `switch_hoisted_test`: same, but with `var foo="foo".part` above the loop
  and used in the switch
- `fn`: switch with smartmatch, with `{|v| "foo".contains(v)}` in each test
- `fn_hoisted_test`: same, but with `var foo={...}` above the loop and
  used in the switch
- `ifthen`: if/then tree using `contains` (fastest possible, as far as I know)
- `adapter`: **switcheq** with **equality**, not smartmatch, and a
  `PartTestAdapter` (suggested by @mhermier [here]).

[here]: https://github.com/wren-lang/wren/pull/1009#issuecomment-839525294
