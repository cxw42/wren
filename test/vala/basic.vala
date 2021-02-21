using Wren;

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
  print("Ver %d.%d.%d, vm %p\n",
        Wren.VERSION_MAJOR, Wren.VERSION_MINOR, Wren.VERSION_PATCH,
        vm);

  var result = vm.Interpret("main", "System.print(\"howdy\")");
  print("Got %s\n", result.to_string());
  return 0;
}
