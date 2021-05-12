for(iter in 1..1525) {
  var topic = "a" // can't possibly match
  var case1 = "1".part
  var case2 = "2".part
  var case3 = "3".part
  var case4 = "4".part
  var case5 = "5".part
  var case6 = "6".part
  var case7 = "7".part
  var case8 = "8".part
  var case9 = "9".part
  var case10 = "10".part
  var case11 = "11".part
  var case12 = "12".part
  var case13 = "13".part
  switch(topic) {
    case1: Fiber.abort("matched 1")
    case2: Fiber.abort("matched 2")
    case3: Fiber.abort("matched 3")
    case4: Fiber.abort("matched 4")
    case5: Fiber.abort("matched 5")
    case6: Fiber.abort("matched 6")
    case7: Fiber.abort("matched 7")
    case8: Fiber.abort("matched 8")
    case9: Fiber.abort("matched 9")
    case10: Fiber.abort("matched 10")
    case11: Fiber.abort("matched 11")
    case12: Fiber.abort("matched 12")
    case13: Fiber.abort("matched 13")
  } //switch
} //iter
