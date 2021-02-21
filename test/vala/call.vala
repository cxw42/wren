// call.vala: test function calls

// Modified from example/embedding/main.c
void basicWrite(Wren.VM vm, string text)
{
  print("%s", text);
}

void basicError(Wren.VM vm, Wren.ErrorType errorType,
             string module, int line,
             string msg)
{
  switch (errorType)
  {
    case COMPILE:
    {
      print("[%s line %d] [Error] %s\n", module, line, msg);
    } break;
    case STACK_TRACE:
    {
      print("[%s line %d] in %s\n", module, line, msg);
    } break;
    case RUNTIME:
    {
      print("[Runtime Error] %s\n", msg);
    } break;
  }
}

public static int main(string[] args)
{
  Wren.Configuration cfg = Wren.Configuration();
  Wren.InitConfiguration(ref cfg);
  cfg.writeFn = basicWrite;
  cfg.errorFn = basicError;

  var vm = new Wren.VM(cfg);

  // Compile a function.
  // Code example modified from https://wren.io/embedding/calling-wren-from-c.html
  var result = vm.Interpret("main", """
class GameEngine {
  static update(time) {
    System.printAll(["The time is ", time])
  }
}
""");
  print("Got %s\n", result.to_string());
  if(result != SUCCESS) {
    return 1;
  }

  // Call the function
  var fnToCall = vm.MakeCallHandleAuto("update(_)");
  vm.EnsureSlots(2);
  vm.GetVariable("main", "GameEngine", 0);  // slot 0 <- receiver
  vm.SetSlotString(1, "Hello, world!");     // slot 1 <- argument

  result = vm.CallAuto(fnToCall);

  return 0;
}
