// @mhermier
class PartTestAdapter {
  construct new(value) {
    _value = value
  }
  ==(rhs) { rhs.contains(_value) }
}
for(iter in 1..100) {
  var topic = "a" // can't possibly match
  switcheq(PartTestAdapter.new(topic)) {
    "1": 1            //Fiber.abort("matched 1")
    "2": 1            //Fiber.abort("matched 2")
    "3": 1            //Fiber.abort("matched 3")
    "4": 1            //Fiber.abort("matched 4")
    "5": 1            //Fiber.abort("matched 5")
    "6": 1            //Fiber.abort("matched 6")
    "7": 1            //Fiber.abort("matched 7")
    "8": 1            //Fiber.abort("matched 8")
    "9": 1            //Fiber.abort("matched 9")
    "10": 1            //Fiber.abort("matched 10")
    "11": 1            //Fiber.abort("matched 11")
    "12": 1            //Fiber.abort("matched 12")
    "13": 1            //Fiber.abort("matched 13")
  } //switch
} //iter
