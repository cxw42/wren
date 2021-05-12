for(iter in 1..100) {
  var topic = "a" // can't possibly match
  if(false) { // so the loop below can be regular
  } else if("1".contains(topic)) {
    Fiber.abort("matched 1")
  } //last endif
} //iter
