for(iter in 1..1525) {
  var topic = "a" // can't possibly match
  switch(topic) {
    {|v| "1".contains(v) }: Fiber.abort("matched 1")
  } //switch
} //iter
