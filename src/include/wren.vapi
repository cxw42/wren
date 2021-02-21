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

  /**
   * Reference-counted wrapper for Handle.
   *
   * Use this instead of a bare Handle whenever possible.
   */
  public class HandleAuto
  {
    private VM vm;
    private Handle handle;

    internal unowned Handle GetHandle()
    {
      return handle;
    }

    public HandleAuto(VM vm, owned Handle handle)
    {
      this.vm = vm;
      this.handle = handle;
    }

    ~HandleAuto()
    {
      vm.ReleaseHandle((owned)handle);
    }
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

  [CCode(cprefix = "WREN_ERROR_", has_type_id = false)]
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
  /**
   * Virtual machine.
   *
   * This class includes all functions taking a WrenVM as the first parameter.
   * It also includes {@link HandleAuto} equivalents of all the {@link Handle}
   * functions.
   */
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

    /**
     * Create a new handle for a method of the given signature.
     *
     * The resulting handle can be used with any receiver that provides
     * a function matching that signature.
     */
    public Handle MakeCallHandle(string signature);

    /** Make a HandleAuto for a function */
    public HandleAuto MakeCallHandleAuto(string signature)
    {
      return new HandleAuto(this, MakeCallHandle(signature));
    }

    public InterpretResult Call(Handle method);
    public InterpretResult CallAuto(HandleAuto method)
    {
      return Call(method.GetHandle());
    }

    public void ReleaseHandle(owned Handle handle);

    public int GetSlotCount();
    public void EnsureSlots(int numSlots);

    public Type GetSlotType(int slot);
    public bool GetSlotBool(int slot);
    public unowned uint8[] GetSlotBytes(int slot);
    public double GetSlotDouble(int slot);
    public void *GetSlotForeign(int slot);
    public unowned string GetSlotString(int slot);

    /** Create a new handle for the value in the given slot */
    public Handle GetSlotHandle(int slot);

    public HandleAuto GetSlotHandleAuto(int slot)
    {
      return new HandleAuto(this, GetSlotHandle(slot));
    }

    public void SetSlotBool(int slot, bool value);
    public void SetSlotBytes(int slot, uint8[] bytes);
    public void SetSlotDouble(int slot, double value);
    public void *SetSlotNewForeign(int slot, int classSlot, size_t size);
    public void SetSlotNewList(int slot);
    public void SetSlotNewMap(int slot);
    public void SetSlotNull(int slot);
    public void SetSlotString(int slot, string text);
    public void SetSlotHandle(int slot, Handle handle);

    public void SetSlotHandleAuto(int slot, HandleAuto handle)
    {
      SetSlotHandle(slot, handle.GetHandle());
    }

    public int GetListCount(int slot);
    public void GetListElement(int listSlot, int index, int elementSlot);
    public void SetListElement(int listSlot, int index, int elementSlot);
    public void InsertInList(int listSlot, int index, int elementSlot);

    public int GetMapCount(int slot);
    public int GetMapContainsKey(int mapSlot, int keySlot);
    public void GetMapValue(int mapSlot, int keySlot, int elementSlot);
    public void SetMapValue(int mapSlot, int keySlot, int elementSlot);
    public void RemoveMapValue(int mapSlot, int keySlot, int removedValueSlot);

    public void GetVariable(string module, string name, int slot);
    public bool HasVariable(string module, string name);

    public bool HasModule(string module);

    public void AbortFiber(int slot);

    public void *GetUserData();
    public void SetUserData(void *userData);
  } //class VM

} //namespace Wren
