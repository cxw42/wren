// @mhermier
class PartTestAdapter {
  construct new(value) {
    _value = value
  }
  ==(rhs) { rhs.contains(_value) }
}
for(iter in 1..575) {
  var topic = "a" // can't possibly match
  switcheq(PartTestAdapter.new(topic)) {
    "1": 1            //Fiber.abort("matched 1")
    "2": 1            //Fiber.abort("matched 2")
    "3": 1            //Fiber.abort("matched 3")
    "4": 1            //Fiber.abort("matched 4")
    "5": 1            //Fiber.abort("matched 5")
    "6": 1            //Fiber.abort("matched 6")
    "7": 1            //Fiber.abort("matched 7")
    "8": 1            //Fiber.abort("matched 8")
    "9": 1            //Fiber.abort("matched 9")
    "10": 1            //Fiber.abort("matched 10")
    "11": 1            //Fiber.abort("matched 11")
    "12": 1            //Fiber.abort("matched 12")
    "13": 1            //Fiber.abort("matched 13")
    "14": 1            //Fiber.abort("matched 14")
    "15": 1            //Fiber.abort("matched 15")
    "16": 1            //Fiber.abort("matched 16")
    "17": 1            //Fiber.abort("matched 17")
    "18": 1            //Fiber.abort("matched 18")
    "19": 1            //Fiber.abort("matched 19")
    "20": 1            //Fiber.abort("matched 20")
    "21": 1            //Fiber.abort("matched 21")
    "22": 1            //Fiber.abort("matched 22")
    "23": 1            //Fiber.abort("matched 23")
    "24": 1            //Fiber.abort("matched 24")
    "25": 1            //Fiber.abort("matched 25")
    "26": 1            //Fiber.abort("matched 26")
    "27": 1            //Fiber.abort("matched 27")
    "28": 1            //Fiber.abort("matched 28")
    "29": 1            //Fiber.abort("matched 29")
    "30": 1            //Fiber.abort("matched 30")
    "31": 1            //Fiber.abort("matched 31")
    "32": 1            //Fiber.abort("matched 32")
    "33": 1            //Fiber.abort("matched 33")
    "34": 1            //Fiber.abort("matched 34")
    "35": 1            //Fiber.abort("matched 35")
    "36": 1            //Fiber.abort("matched 36")
    "37": 1            //Fiber.abort("matched 37")
    "38": 1            //Fiber.abort("matched 38")
    "39": 1            //Fiber.abort("matched 39")
    "40": 1            //Fiber.abort("matched 40")
    "41": 1            //Fiber.abort("matched 41")
    "42": 1            //Fiber.abort("matched 42")
    "43": 1            //Fiber.abort("matched 43")
    "44": 1            //Fiber.abort("matched 44")
    "45": 1            //Fiber.abort("matched 45")
    "46": 1            //Fiber.abort("matched 46")
    "47": 1            //Fiber.abort("matched 47")
    "48": 1            //Fiber.abort("matched 48")
    "49": 1            //Fiber.abort("matched 49")
    "50": 1            //Fiber.abort("matched 50")
  } //switch
} //iter
