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
for(iter in 1..10000) {
  var topic = "a" // can't possibly match
  switch(topic) {
    case1: 1
    case2: 1
    case3: 1
    case4: 1
    case5: 1
    case6: 1
    case7: 1
    case8: 1
    case9: 1
    case10: 1
  } //switch
  
  // Waste some time
  for(count in 1..1000) {
    1
  }

} //iter
