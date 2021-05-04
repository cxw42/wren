/*
from https://github.com/wren-lang/wren/issues/956#issuecomment-813660551
expr > 6
expr != 2
expr in 1..50
expr.isEven
expr is String
*/

/* pattern matching could end up metastasizing on us: value matching, type matching, list destructing, map destructuring, object destructuring, etc. Ranges? Predicate clauses? Wildcards?
 * from https://github.com/wren-lang/wren/issues/352#issuecomment-237459289
 */
