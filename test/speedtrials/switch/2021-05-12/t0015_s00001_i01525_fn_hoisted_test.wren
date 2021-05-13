var case1 = Fn.new { |v| "1".contains(v) }
for(iter in 1..1525) {
  var topic = "a" // can't possibly match
  switch(topic) {
    case1: 1            //Fiber.abort("matched 1")
  } //switch
} //iter
