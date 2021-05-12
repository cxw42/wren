for(iter in 1..575) {
  var topic = "a" // can't possibly match
  switch(topic) {
    "1".part: Fiber.abort("matched 1")
  } //switch
} //iter
