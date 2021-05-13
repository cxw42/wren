// @mhermier
class PartTestAdapter {
  construct new(value) {
    _value = value
  }
  ==(rhs) { rhs.contains(_value) }
}
for(iter in 1..1050) {
  var topic = "a" // can't possibly match
  switcheq(PartTestAdapter.new(topic)) {
    "1": 1            //Fiber.abort("matched 1")
  } //switch
} //iter
