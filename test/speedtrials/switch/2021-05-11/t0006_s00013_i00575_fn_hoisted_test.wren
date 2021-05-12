for(iter in 1..575) {
  var topic = "a" // can't possibly match
  var case1 = Fn.new { |v| "1".contains(v) }
  var case2 = Fn.new { |v| "2".contains(v) }
  var case3 = Fn.new { |v| "3".contains(v) }
  var case4 = Fn.new { |v| "4".contains(v) }
  var case5 = Fn.new { |v| "5".contains(v) }
  var case6 = Fn.new { |v| "6".contains(v) }
  var case7 = Fn.new { |v| "7".contains(v) }
  var case8 = Fn.new { |v| "8".contains(v) }
  var case9 = Fn.new { |v| "9".contains(v) }
  var case10 = Fn.new { |v| "10".contains(v) }
  var case11 = Fn.new { |v| "11".contains(v) }
  var case12 = Fn.new { |v| "12".contains(v) }
  var case13 = Fn.new { |v| "13".contains(v) }
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
