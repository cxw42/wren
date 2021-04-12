// option 1 as I understand it
if (TOMLScanner.isAlphanumeric(char)) {
  scanAlphanumeric()
} else if (TOMLScanner.isWhitespace(char)) {  
  // No-op.
} else switch(char) {
  "=": addToken(Equal)
  "\"": {
    if (peek() == "\"") {
      advance()
      elidedMultiline()
    } else {
      scanString()
    }
  } 
  "#": scanComment()
  "[": addToken(LeftBracket)
  "]": addToken(RightBracket)
  "'": scanString("'")
  ",": addToken(Comma)
  "{": addToken(LeftBrace)
  "}": addToken(RightBrace)
  else throwScannerError()
}







