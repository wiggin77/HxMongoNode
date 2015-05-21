package js.node.mongodb;

/**
 * A class representation of the BSON Code type.
 */
@:jsRequire("mongodb", "Code")
extern class Code
{
	
	/**
	 * A class representation of the BSON Code type.
	 * @param  code  - a string or function.
	 * @param  scope - an optional scope for the function.
	 */
	function new(code:haxe.extern.EitherType<String,Dynamic->Void>, scope:Dynamic):Void;
	
}