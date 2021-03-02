^title Meta Class

Access to the Wren interpreter, from within Wren code.

## Static Methods

### Meta.**getModuleVariables**(module)

TODO

<pre class="snippet">
Meta.getModuleVariables("foo")
</pre>

### Meta.**eval**(source)

TODO

<pre class="snippet">
var result = Meta.eval("2+2")   //> 4
</pre>

### Meta.**compileExpression**(source)

TODO

<pre class="snippet">
var fn = Meta.compileExpression("2+2")
var result = fn.call()    //> 4
</pre>

### Meta.**compile**(source)

TODO

<pre class="snippet">
var fn = Meta.compile("return 2+2")
var result = fn.call()    //> 4
</pre>
