for(iter in 1..1050) {
  var topic = "a" // can't possibly match
  switch(topic) {
    {|v| "1".contains(v) }: 1            //Fiber.abort("matched 1")
    {|v| "2".contains(v) }: 1            //Fiber.abort("matched 2")
    {|v| "3".contains(v) }: 1            //Fiber.abort("matched 3")
    {|v| "4".contains(v) }: 1            //Fiber.abort("matched 4")
    {|v| "5".contains(v) }: 1            //Fiber.abort("matched 5")
    {|v| "6".contains(v) }: 1            //Fiber.abort("matched 6")
    {|v| "7".contains(v) }: 1            //Fiber.abort("matched 7")
    {|v| "8".contains(v) }: 1            //Fiber.abort("matched 8")
    {|v| "9".contains(v) }: 1            //Fiber.abort("matched 9")
    {|v| "10".contains(v) }: 1            //Fiber.abort("matched 10")
    {|v| "11".contains(v) }: 1            //Fiber.abort("matched 11")
    {|v| "12".contains(v) }: 1            //Fiber.abort("matched 12")
    {|v| "13".contains(v) }: 1            //Fiber.abort("matched 13")
  } //switch
} //iter
