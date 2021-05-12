for(iter in 1..1050) {
  var topic = "a" // can't possibly match
  var case1 = "1".part
  switch(topic) {
    case1: Fiber.abort("matched 1")
  } //switch
} //iter
