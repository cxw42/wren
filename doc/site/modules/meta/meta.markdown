^title Meta Class

Access to the Wren interpreter, from within Wren code.

## Static Methods

### Meta.**getModuleVariables**(module)

TODO

<pre class="snippet">
Meta.getModuleVariables("foo")
</pre>

### Meta.**eval**(source)

Compile and run the given `source` in the current module.

<pre class="snippet">
System.print(Meta.eval("2+2"))   //> 4
</pre>

### Meta.**compileExpression**(source)

Compile the given `source` in the current module.  `source` must be an expression, not a statement.
Returns a new [Fn][] representing the compiled expression.

<pre class="snippet">
var fn = Meta.compileExpression("2+2")
System.print(fn.call())    //> 4
</pre>

[Fn]: ../core/fn.html

### Meta.**compile**(source)

Compile the given `source` in the current module.  `source` must be a statement, not a bare expression.
Returns a new [Fn][] representing the compiled statement.

<pre class="snippet">
var fn = Meta.compile("return 2+2")
System.print(fn.call())    //> 4
</pre>
