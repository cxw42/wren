// Original - from wren-toml [1]
if (TOMLScanner.isAlphanumeric(char)) {
  scanAlphanumeric()
} else if (TOMLScanner.isWhitespace(char)) {  
  // No-op.
} else if (char == "=") {
  addToken(Equal)
} else if (char == "\"") {
  if (peek() == "\"") {
    advance()
    elidedMultiline() // removed for brevity
  } else {
    scanString()
  }
} else if (char == "#") {
  scanComment()
} else if (char == "[") {
  addToken(LeftBracket)
} else if (char == "]") {
  addToken(RightBracket)
} else if (char == "'") {
  scanString("'")
} else if (char == ",") {
  addToken(Comma)
} else if (char == "{") {
  addToken(LeftBrace)
} else if (char == "}") {
  addToken(RightBrace)
} else {
  throwScannerError()
}
