for(iter in 1..1525) {
  var topic = "a" // can't possibly match
  switch(topic) {
    {|v| "1".contains(v) }: Fiber.abort("matched 1")
    {|v| "2".contains(v) }: Fiber.abort("matched 2")
    {|v| "3".contains(v) }: Fiber.abort("matched 3")
    {|v| "4".contains(v) }: Fiber.abort("matched 4")
    {|v| "5".contains(v) }: Fiber.abort("matched 5")
    {|v| "6".contains(v) }: Fiber.abort("matched 6")
    {|v| "7".contains(v) }: Fiber.abort("matched 7")
    {|v| "8".contains(v) }: Fiber.abort("matched 8")
    {|v| "9".contains(v) }: Fiber.abort("matched 9")
    {|v| "10".contains(v) }: Fiber.abort("matched 10")
    {|v| "11".contains(v) }: Fiber.abort("matched 11")
    {|v| "12".contains(v) }: Fiber.abort("matched 12")
    {|v| "13".contains(v) }: Fiber.abort("matched 13")
    {|v| "14".contains(v) }: Fiber.abort("matched 14")
    {|v| "15".contains(v) }: Fiber.abort("matched 15")
    {|v| "16".contains(v) }: Fiber.abort("matched 16")
    {|v| "17".contains(v) }: Fiber.abort("matched 17")
    {|v| "18".contains(v) }: Fiber.abort("matched 18")
    {|v| "19".contains(v) }: Fiber.abort("matched 19")
    {|v| "20".contains(v) }: Fiber.abort("matched 20")
    {|v| "21".contains(v) }: Fiber.abort("matched 21")
    {|v| "22".contains(v) }: Fiber.abort("matched 22")
    {|v| "23".contains(v) }: Fiber.abort("matched 23")
    {|v| "24".contains(v) }: Fiber.abort("matched 24")
    {|v| "25".contains(v) }: Fiber.abort("matched 25")
  } //switch
} //iter
