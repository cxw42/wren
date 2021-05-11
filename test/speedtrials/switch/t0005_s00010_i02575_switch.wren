for(iter in 1..2575) {
  var topic = "a" // can't possibly match
  switch(topic) {
    "1".part: Fiber.abort("matched 1")
    "2".part: Fiber.abort("matched 2")
    "3".part: Fiber.abort("matched 3")
    "4".part: Fiber.abort("matched 4")
    "5".part: Fiber.abort("matched 5")
    "6".part: Fiber.abort("matched 6")
    "7".part: Fiber.abort("matched 7")
    "8".part: Fiber.abort("matched 8")
    "9".part: Fiber.abort("matched 9")
    "10".part: Fiber.abort("matched 10")
  } //switch
} //iter
