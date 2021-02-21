// wren.vapi: Vala bindings for Wren
// See wren.h for documentation.  This file is in the same order as wren.h.
//
// By Christopher White <cxwembedded@gmail.com>
// SPDX-License-Identifier: MIT
//
// TODO: check the ownership on Handle instances.

[CCode(cheader_filename = "wren.h", lower_case_cprefix="wren")]
namespace Wren {

  [CCode(cname="WREN_VERSION_MAJOR")]
  extern int VERSION_MAJOR;
  [CCode(cname="WREN_VERSION_MINOR")]
  extern int VERSION_MINOR;
  [CCode(cname="WREN_VERSION_PATCH")]
  extern int VERSION_PATCH;
  [CCode(cname="WREN_VERSION_NUMBER")]
  extern int VERSION_NUMBER;

  /** Handle to a Wren object */
  [CCode(has_type_id = false)]
  [Compact]
  public extern class Handle
  {
  }

  [CCode(delegate_target_pos = 2)]
  public delegate void *ReallocateFn(void *memory, size_t newSize);

  [CCode(has_target = false)]
  public delegate void ForeignMethodFn(VM vm);

  [CCode(has_target = false)]
  public delegate void FinalizerFn(void *data);

  [CCode(has_target = false)]
  public delegate string ResolveModuleFn(VM vm, string importer, string name);

  [CCode(has_target = false)]
  public delegate void LoadModuleCompleteFn(VM vm, string name, LoadModuleResult result);

  public struct LoadModuleResult
  {
    string source;
    LoadModuleCompleteFn onComplete;
    void *userData;
  }

  [CCode(has_target = false)]
  public delegate LoadModuleResult LoadModuleFn(VM vm, string name);

  [CCode(has_target = false)]
  public delegate ForeignMethodFn BindForeignMethodFn(VM vm, string module,
                                                      string className,
                                                      bool isStatic,
                                                      string signature);

  [CCode(has_target = false)]
  public delegate void WriteFn(VM vm, string text);

  [CCode()]
  public enum ErrorType
  {
    COMPILE,
    RUNTIME,
    STACK_TRACE,
  }

  [CCode(has_target = false)]
  public delegate void ErrorFn(VM vm, ErrorType type, string module,
                               int line, string message);

  public struct ForeignClassMethods
  {
    ForeignMethodFn allocate;
    FinalizerFn finalize;
  }

  [CCode(has_target = false)]
  public delegate ForeignClassMethods BindForeignClassFn(VM vm, string module, string className);

  /** Virtual-machine configuration */
  [CCode(destroy_function = "")]
  public struct Configuration
  {
    ReallocateFn reallocateFn;
    ResolveModuleFn resolveModuleFn;
    LoadModuleFn loadModuleFn;
    BindForeignMethodFn bindForeignMethodFn;
    BindForeignClassFn bindForeignClassFn;
    WriteFn writeFn;
    ErrorFn errorFn;
    size_t initialHeapSize;
    size_t minHeapSize;
    int heapGrowthPercent;
    void *userData;
  }

  [CCode(cprefix="WREN_RESULT_", has_type_id = "false")]
  public enum InterpretResult
  {
    SUCCESS,
    COMPILE_ERROR,
    RUNTIME_ERROR,
  }

  public enum Type {
    BOOL, NUM, FOREIGN, LIST, MAP, NULL, STRING, UNKNOWN,
  }

  public extern void InitConfiguration(ref Configuration configuration);

  // For some reason, I have to repeat cheader_filename here.  I don't know why.
  /** Virtual machine */
  [CCode(cheader_filename = "wren.h", free_function = "wrenFreeVM",
         has_type_id = false, cprefix="wren")]
  [Compact]
  public extern class VM
  {
    /** Constructor */
    [CCode(cname = "wrenNewVM")]
    public VM(Configuration? config);

    public void CollectGarbage();

    public InterpretResult Interpret(string module, string source);

    public Handle MakeCallHandle(string signature);
    public InterpretResult Call(Handle method);
    void ReleaseHandle(owned Handle handle);

    int GetSlotCount();
    void EnsireSlots(int numSlots);

    Type GetSlotType(int slot);
    bool GetSlotBool(int slot);
    unowned uint8[] GetSlotBytes(int slot);
    double GetSlotDouble(int slot);
    void *GetSlotForeign(int slot);
    unowned string GetSlotString(int slot);
    Handle GetSlotHAndle(int slot);

    void SetSlotBool(int slot, bool value);
    void SetSlotBytes(int slot, uint8[] bytes);
    void SetSlotDouble(int slot, double value);
    void *SetSlotNewForeign(int slot, int classSlot, size_t size);
    void SetSlotNewList(int slot);
    void SetSlotNewMap(int slot);
    void SetSlotNull(int slot);
    void SetSlotString(int slot, string text);
    void SetSlotHandle(int slot, Handle handle);

    int GetListCount(int slot);
    void GetListElement(int listSlot, int index, int elementSlot);
    void SetListElement(int listSlot, int index, int elementSlot);
    void InsertInList(int listSlot, int index, int elementSlot);

    int GetMapCount(int slot);
    int GetMapContainsKey(int mapSlot, int keySlot);
    void GetMapValue(int mapSlot, int keySlot, int elementSlot);
    void SetMapValue(int mapSlot, int keySlot, int elementSlot);
    void RemoveMapValue(int mapSlot, int keySlot, int removedValueSlot);

    void GetVariable(string module, string name);
    bool HasVariable(string module, string name);

    bool HasModule(string module);

    void AbortFiber(int slot);

    void *GetUserData();
    void SetUserData(void *userData);
  } //class VM

} //namespace Wren
