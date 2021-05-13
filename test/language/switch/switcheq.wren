switcheq(1) {
  1: System.print("yes")    // expect: yes
  else: System.print("no")
}

switcheq(2) {
  1: System.print("yes")
  else: System.print("no")  // expect: no
}

// Compare to smartmatch
switch("a") {
  "bar".part: System.print("yes")   // expect: yes
  else: System.print("no")
}

switcheq("a") {
    "bar".part: System.print("yes")
    else: System.print("no")        // expect: no
}
