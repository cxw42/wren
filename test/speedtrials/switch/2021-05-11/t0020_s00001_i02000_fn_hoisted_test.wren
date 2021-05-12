for(iter in 1..2000) {
  var topic = "a" // can't possibly match
  var case1 = Fn.new { |v| "1".contains(v) }
  switch(topic) {
    case1: Fiber.abort("matched 1")
  } //switch
} //iter
