// 00_ladder_direct.wren: speed test 00, if/else ladder with direct comparisons

var iterations = 100000

// Match all cases, but not in the same order they are listed in the switch
var values = [99, 1, 100, "a", 3, 7]

var match = {}
for(value in values) {
  match[value] = 0
}

var isEven = Fn.new {|v| v%2 == 0}

for (i in 1..iterations) {
  for(value in values) {

    if(value == 1) {
      match[value] = match[value] + 1
    } else if(value == "a") {
      match[value] = match[value] + 1
    } else if((2..5).contains(value)) {
      match[value] = match[value] + 1
    } else if([7, 9].contains(value)) {
      match[value] = match[value] + 1
    } else if(isEven.call(value)) {
      match[value] = match[value] + 1
    } else {
      match[value] = match[value] + 1
    }

  }
}

for(value in values) {
  if(match[value] != iterations) {
    Fiber.abort("Value %(value) got %(match[value]), expected %(iterations)")
  }
}
