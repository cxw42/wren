// 00_switch.wren: speed test 00, switch version

var iterations = 100000

// Match all cases, but not in the same order they are listed in the switch
var values = [99, 1, 100, "a", 3, 7]

var match = {}
for(value in values) {
  match[value] = 0
}

for (i in 1..iterations) {
  for(value in values) {

    switch(value) {
      1: match[value] = match[value] + 1
      "a": match[value] = match[value] + 1
      2..5: match[value] = match[value] + 1
      [7, 9]: match[value] = match[value] + 1
      {|v| v%2 == 0}: match[value] = match[value] + 1
      else: match[value] = match[value] + 1
    }

  }
}

for(value in values) {
  if(match[value] != iterations) {
    Fiber.abort("Value %(value) got %(match[value]), expected %(iterations)")
  }
}
