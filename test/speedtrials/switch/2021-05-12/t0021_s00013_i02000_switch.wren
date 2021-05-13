for(iter in 1..2000) {
  var topic = "a" // can't possibly match
  switch(topic) {
    "1".part: 1            //Fiber.abort("matched 1")
    "2".part: 1            //Fiber.abort("matched 2")
    "3".part: 1            //Fiber.abort("matched 3")
    "4".part: 1            //Fiber.abort("matched 4")
    "5".part: 1            //Fiber.abort("matched 5")
    "6".part: 1            //Fiber.abort("matched 6")
    "7".part: 1            //Fiber.abort("matched 7")
    "8".part: 1            //Fiber.abort("matched 8")
    "9".part: 1            //Fiber.abort("matched 9")
    "10".part: 1            //Fiber.abort("matched 10")
    "11".part: 1            //Fiber.abort("matched 11")
    "12".part: 1            //Fiber.abort("matched 12")
    "13".part: 1            //Fiber.abort("matched 13")
  } //switch
} //iter
