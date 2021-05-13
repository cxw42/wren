for(iter in 1..100) {
  var topic = "a" // can't possibly match
  switch(topic) {
    {|v| "1".contains(v) }: 1            //Fiber.abort("matched 1")
  } //switch
} //iter
