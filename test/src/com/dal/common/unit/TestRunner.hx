/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
package com.dal.common.unit;

import com.dal.common.unit.AsyncNotify;
import haxe.Timer;
import haxe.rtti.Meta;
import Reflect;
import promhx.Deferred;
import promhx.Promise;


/**
 * Simple struct for tracking context during asynchronous execution of test cases.
 */
private typedef TestCaseContext = 
{
	var deferred:Deferred<TestResult>;
	var it:Iterator<TestCase>;
	var result:TestResult;
}

/**
 * Simple struct for tracking context during asynchrous execution of test case methods.
 */
private typedef RunMethodContext = 
{
	var deferred:Deferred<Bool>;	
	var tc:TestCase;
	var it:Iterator<String>;
	var result:TestResult;
}

/**
 * An enum expressing the type of method in a TestCase class. (async or sync).
 */
private enum TestMethodType
{
	None;
	Test;
	TestAsync;
}

/**
 * Runs one or more TestCase classes and reports the results.
 */
class TestRunner 
{
	/**
	 * The list of TestCase objects to run.
	 */
	private var m_listCases  : List<TestCase>;

	/**
	 * TextField for displaying the results in Flash.
	 */
	#if flash9
	static var tf : flash.text.TextField = null;
	#elseif flash
	static var tf : flash.TextField = null;
	#end

	/**
	 * Prints the object to console and mirrors to platform specific UI element.
	 * @param	v - the object to print.
	 * @param 	color - the color to print (Flash, JS).
	 */
	public static dynamic function print( v : Dynamic, color:Int = 0x000000 ) untyped 
	{
		#if flash9
			var textFormat: flash.text.TextFormat = new flash.text.TextFormat();
	    	textFormat.color = color;

			if( tf == null ) 
			{
				tf = new flash.text.TextField();
				tf.width = flash.Lib.current.stage.stageWidth;
				tf.autoSize = flash.text.TextFieldAutoSize.LEFT;
				tf.wordWrap = true;
				flash.Lib.current.addChild(tf);
			}

			var oldSize : Int = tf.length;
			tf.appendText(v);
			var newSize : Int = tf.length;

			tf.setTextFormat(textFormat, oldSize, newSize);

			if (v.indexOf("Test.hx") != -1) 
			{
				var startIdx: Int = v.indexOf("Test.hx");

				textFormat.color = 0xFF0000;
				tf.setTextFormat(textFormat, oldSize + v.lastIndexOf('\n', startIdx) , oldSize + v.indexOf('\n', startIdx));
			}
      		Console.stdout().print(Std.string(v));
		#elseif flash
			var root = flash.Lib.current;
			if( tf == null ) 
			{
				root.createTextField("__tf",1048500,0,0,flash.Stage.width,flash.Stage.height+30);
				tf = root.__tf;
				tf.wordWrap = true;
			}
			var s = flash.Boot.__string_rec(v,"");
			tf.text += s;
			while( tf.textHeight > flash.Stage.height ) 
			{
				var lines = tf.text.split("\r");
				lines.shift();
				tf.text = lines.join("\n");
			}
			Console.stdout().print(Std.string(v));
		#elseif neko
			__dollar__print(v);
		#elseif php
			php.Lib.print(v);
		#elseif cpp
			cpp.Lib.print(v);
		#elseif js
			var msg = js.Boot.__string_rec(v,"");
			var d;
            if( __js__("typeof")(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null ) 
			{
                msg = StringTools.htmlEscape(msg);
                msg = msg.split("\n").join("<br/>");
                d.innerHTML += msg;
            }
			else if (  __js__("typeof process") != "undefined" && __js__("process").stdout != null &&
					   __js__("process").stdout.write != null)
			{
				__js__("process").stdout.write(msg); // node
			}
			else if (  __js__("typeof console") != "undefined" && __js__("console").log != null )
			{
				__js__("console").log(msg); // document-less js (which may include a line break)
			}
		#elseif cs
			cs.system.Console.Write(v);
		#elseif java
			var str:String = v;
			untyped __java__("java.lang.System.out.print(str)");
		#end
	}

	/**
	 * Custom trace method to override haxe.Log.trace
	 * @param	v - the object to log
	 * @param	p - optional position info.
	 */
	private static function customTrace( v, ?p : haxe.PosInfos ) 
	{
		print(p.fileName+":"+p.lineNumber+": "+Std.string(v)+"\n", 0x0000FF);
	}

	/**
	 * Constructor
	 */
	public function new() 
	{
		m_listCases = new List();
	}

	/**
	 * Adds a test case to the list.
	 * @param	c - the TestCase to add.
	 */
	public function add( c:TestCase ) : Void
	{
		m_listCases.add(c);
	}

	/**
	 * Runs the list of TestCase objects.
	 * @return Bool - true if all tests completed successfully.
	 */
	public function run() : Promise<TestResult>
	{
		// Create a new test context for this run instance.
		var bDone = false;
		var result = new TestResult();
		var deferred = new Deferred<TestResult>();
		var promise = deferred.promise();
		var it = m_listCases.iterator();
		var tcc:TestCaseContext = { "deferred":deferred, "it":it, "result":result };

		promise.then(function(tr) { bDone = true; } );

		Timer.delay(function() { runNextCase(tcc); }, 10);

		// Don't let the main thread exit until all tests are complete, 
		// otherwise it will kill the process before the tests get run.
		//#if sys
		//	while(!abDone.get())
		//	{
		//		ThreadUtil.sleep(500);
		//	}
		//#end

		return promise;
	}

	/**
	 * Runs the next TestCase in the specified context's iterator, meaning all test methods will be 
	 * executed and results collected.
	 * @param  tcc - the TestCaseContext containing the iterator.
	 */
	private function runNextCase(tcc:TestCaseContext) : Void
	{
		if(tcc.it.hasNext())
		{
			var tc:TestCase = tcc.it.next();
			var prom = runCase(tc, tcc.result);
			prom.then(function(b) { runNextCase(tcc); return b; } );
		}
		else
		{
			// We're done all test cases.  Print results and resolve the promise.
			print("\n");
			print(tcc.result.toString());
			tcc.deferred.resolve(tcc.result);
		}
	}

	/**
	 * Runs a specific TestCase.
	 * @param	t - the TestCase to run.
	 * @param   result - the TestResult to populate with results.
	 * @return Promise<Bool>
	 */
	private function runCase( t:TestCase, result:TestResult ) : Promise<Bool> 	
	{
		var old = haxe.Log.trace;
		haxe.Log.trace = customTrace;

		var cl = Type.getClass(t);
		var fields = Type.getInstanceFields(cl);

		print( "Class: " + Type.getClassName(cl) + " ");

		var it = fields.iterator();
		var deferred = new Deferred<Bool>();
		var prom = deferred.promise();
		var rmc:RunMethodContext = { "deferred":deferred, "tc":t, "it":it, "result":result };

		runNextMethod(rmc);

		prom.then(function(b) { haxe.Log.trace = old; print("\n"); return b; } );
		return prom;
	}

	/**
	 * Runs the next TestCase method from an iteration of method names.
	 * @param	rmc - run method context containing iterator of method names.
	 */
	private function runNextMethod(rmc:RunMethodContext) : Void
	{
		var deferred = new Deferred<Bool>();
		var prom = deferred.promise();
		
		if (rmc.it.hasNext())
		{
			var strField = rmc.it.next();
			var prom:Promise<Bool>;
			switch(getMethodType(rmc.tc, strField))
			{
				case TestMethodType.Test:
					prom = runMethod(strField, false, rmc);
					
				case TestMethodType.TestAsync:
					prom = runMethod(strField, true, rmc);
					
				case TestMethodType.None:
					// Not a test method - skip.
					var def = new Deferred<Bool>();
					prom = def.promise();
					def.resolve(false);
			}
			
			prom.then(function(b) { runNextMethod(rmc); return b; } );
		}
		else
		{
			// No more methods.  This test case is finished.
			rmc.deferred.resolve(true);
		}
	}
	
	/**
	 * Runs a specific method in a TestCase and records the results.
	 * @param	strMethod - the method to run
	 * @param	bAsync - true if the method should be run as an Async test.
	 * @param	rmc - run method context containing iterator of method names.
	 * @return Promise<Bool>
	 */
	private function runMethod(strMethod:String, bAsync:Bool, rmc:RunMethodContext) : Promise<Bool>
	{
		var deferred = new Deferred<Bool>();
		var prom = deferred.promise();

		// Setup for this test method.
		rmc.tc.currentTest = new TestStatus();
		rmc.tc.currentTest.classname = Type.getClassName(Type.getClass(rmc.tc));
		rmc.tc.currentTest.method = strMethod;
		rmc.tc.setup();		
		
		// Make sure teardown gets called when finished.
		prom.then(function(b) { onMethodComplete(deferred, rmc); return b; } );
		prom.errorThen(function(b) { onMethodComplete(deferred, rmc); return b; } );
		
		try
		{
			var args = new Array<Dynamic>();
			var method = Reflect.field(rmc.tc, strMethod);
			if (bAsync)
			{
				var an = new AsyncNotify(deferred, rmc.tc);
				args.push(an);
				Reflect.callMethod(rmc.tc, method, args);
				// If method takes too long, it might be because 
				// a call to AsyncNotify.done() is missing. 
				Timer.delay(function() { onMethodTimeout(deferred, rmc); }, AsyncNotify.getTimeout());
			}
			else
			{
				Reflect.callMethod(rmc.tc, method, args);
				deferred.resolve(true);
			}
		}
		catch ( e : Dynamic )
		{
			#if js
				rmc.tc.currentTest.error = "exception thrown : " + e + ((e.message != null) ? " [" + e.message + "]" : "");
			#else
				rmc.tc.currentTest.error = "exception thrown : " + e;
			#end

			rmc.tc.currentTest.success = false;
			rmc.tc.currentTest.exception = e;
			rmc.tc.currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());

			if (!deferred.promise().isResolved())
			{
				deferred.resolve(false);
			}
		}
		
		return prom;
	}

	/**
	 * Called when a single test method is finished.
	 * @param 	deferred - the deferred used to single when the test method is finished.
	 * @param	rmc - run method context containing iterator of method names.
	 */
	private function onMethodComplete(deferred:Deferred<Bool>, rmc:RunMethodContext) : Void
	{
		if ( rmc.tc.currentTest.getAndSetDone(true) )
		{
			print(rmc.tc.currentTest.success ? "." : (rmc.tc.currentTest.exception != null ? "E" : "F"));
		}
		else
		{
			rmc.tc.currentTest.success = false;
			rmc.tc.currentTest.error = !rmc.tc.currentTest.timedOut ? "(warning) no assert" : 
			                                                          "(warning, timeout) no assert - did you forget to call AsyncNotify.done()?";
			print("E");
		}
		
		rmc.result.add(rmc.tc.currentTest);

		// Cleanup for next test.
		rmc.tc.tearDown();
	}

	/**
	 * Called when a single test method has timed out.
	 * @param 	deferred - the deferred used to single when the test method is finished.
	 * @param	rmc - run method context containing iterator of method names.
	 */
	private function onMethodTimeout(deferred:Deferred<Bool>, rmc:RunMethodContext) : Void
	{
		rmc.tc.currentTest.timedOut = true;		

		// This will force onMethodComplete to be called.
		if(!deferred.isResolved())
		{
			deferred.resolve(false);
		}
	}
	
	/**
	 * Determines if the specified method is a test method, and whether it should be called asynchronously.
	 * @param	tc - the TestCase object
	 * @param	strField - the field name to check
	 * @return TestMethodType
	 */
	private function getMethodType(tc:TestCase, strField:String) : TestMethodType
	{
		var tmt:TestMethodType = TestMethodType.None;
		
		var field = Reflect.field(tc, strField);
		if ( Reflect.isFunction(field) )
		{
			// Check for @Test metadata or method that starts with "test".
			if (StringTools.startsWith(strField, "test") || hasMeta(tc, strField, "Test"))
			{
				tmt = TestMethodType.Test;	
			}
			
			// Check for @AsynTest metadata.
			if (hasMeta(tc, strField, "AsyncTest"))
			{
				tmt = TestMethodType.TestAsync;
			}
		}
		return tmt;
	}
	
	/**
	 * Returns true if the specified method has a specific metadata.
	 * @param	tc - the TestCase object to check.
	 * @param	strField - the field to check.
	 * @param	strMeta - the metadata field to look for.
	 * @return Bool - true if the field has the metadata.
	 */
	inline private function hasMeta(tc:TestCase, strField:String, strMeta:String) : Bool
	{
			var meta = Meta.getFields(Type.getClass(tc));
			return (Reflect.hasField(meta, strField) && Reflect.hasField(Reflect.field(meta, strField), strMeta));
	}
	
} // End of TestRunner class 
