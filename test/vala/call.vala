// call.vala: test function calls

// Modified from example/embedding/main.c
void basicWrite(Wren.VM vm, string text)
{
  print("Wren says >>%s<<\n", text);
}

public static int main(string[] args)
{
  Wren.Configuration cfg = Wren.Configuration();
  Wren.InitConfiguration(ref cfg);
  cfg.writeFn = basicWrite;

  var vm = new Wren.VM(cfg);

  // Code example modified from https://wren.io/embedding/calling-wren-from-c.html
  var result = vm.Interpret("main", """
class GameEngine {
  static update(time) {
    System.printAll(["The time is ", time]);
  }
}
""");
  print("Got %s\n", result.to_string());
  if(result != SUCCESS) {
    return 1;
  }


  return 0;
}
