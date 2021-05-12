for(iter in 1..575) {
  var topic = "a" // can't possibly match
  if(false) { // so the loop below can be regular
  } else if("1".contains(topic)) {
    Fiber.abort("matched 1")
  } else if("2".contains(topic)) {
    Fiber.abort("matched 2")
  } else if("3".contains(topic)) {
    Fiber.abort("matched 3")
  } else if("4".contains(topic)) {
    Fiber.abort("matched 4")
  } else if("5".contains(topic)) {
    Fiber.abort("matched 5")
  } else if("6".contains(topic)) {
    Fiber.abort("matched 6")
  } else if("7".contains(topic)) {
    Fiber.abort("matched 7")
  } else if("8".contains(topic)) {
    Fiber.abort("matched 8")
  } else if("9".contains(topic)) {
    Fiber.abort("matched 9")
  } else if("10".contains(topic)) {
    Fiber.abort("matched 10")
  } else if("11".contains(topic)) {
    Fiber.abort("matched 11")
  } else if("12".contains(topic)) {
    Fiber.abort("matched 12")
  } else if("13".contains(topic)) {
    Fiber.abort("matched 13")
  } //last endif
} //iter
