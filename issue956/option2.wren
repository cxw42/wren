// option 2 as I understand it
if (TOMLScanner.isAlphanumeric(char)) {
  scanAlphanumeric()
} else if (TOMLScanner.isWhitespace(char)) {  
  // No-op.
} else switch(char) {
  case "=": addToken(Equal)
  case "\"":
    if (peek() == "\"") {
      advance()
      elidedMultiline()
    } else {
      scanString()
    }
  case "#": scanComment()
  case "[": addToken(LeftBracket)
  case "]": addToken(RightBracket)
  case "'": scanString("'")
  case ",": addToken(Comma)
  case "{": addToken(LeftBrace)
  case "}": addToken(RightBrace)
  default throwScannerError()
}
//







