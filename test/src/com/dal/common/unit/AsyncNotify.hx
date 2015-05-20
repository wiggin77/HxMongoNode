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

import com.dal.common.unit.TestCase;
import haxe.Timer;
import promhx.Deferred;
import promhx.Promise;

/**
 * Allows asynchronous test methods to signal when they are finished their test.
 */
class AsyncNotify
{
	/**
	 * Determines how long (in milliseconds) we'll wait for an asynchronous test to complete.
	 */
	private static var 					s_iTimeout:Int = 15000;

	/**
	 * The deferred used to signal the test runner when the test is complete.
	 */
	private var 						m_deferred:Deferred<Bool>;

	/**
	 * The promise associated with the deferred.
	 */
	private var 						m_prom:Promise<Bool>;

	/**
	 * The TestCase currently being run.
	 */
	private var 						m_tc:TestCase;

	/**
	 * The Timer used to timeout an async call that sos taking too long.
	 * We need this so it can be cancelled on successful completion.
	 */
	private var 						m_timer:Timer;

	/**
	 * Constructor
	 * @param	deferred - used to signal the test runner when the test is complete.
	 * @param	tc - the TestCase currently being run.
	 * @param	timer - the Timer used to timeout a async call that is taking too long.
	 */
	@:allow(com.dal.common.unit)
	function new(deferred:Deferred<Bool>, tc:TestCase, timer:Timer) 
	{
		if(deferred == null)
			throw "deferred cannot be null";

		if(tc == null)
			throw "tc cannot be null";

		m_deferred = deferred;
		m_prom = deferred.promise();
		m_tc = tc;
		m_timer = timer;
	}

	/**
	 * Sets the amount of time the test runner will wait for AsyncNotify.done() to be called before timing out.
	 * Defaults to 15000 milliseconds.  Minimum 1000ms.
	 * <p>
	 * To change the timeout for a test method, this must be called before the start of the method, 
	 * such as when the app starts or during the TestCase.setup() method.
	 * 
	 * @param iTimeout - the timeout in milliseonds.
	 */
	public static function setTimeout(iTimeout:Int) : Void
	{
		if(iTimeout < 1000)
		{
			throw "iTimeout must be 1000ms or more";
		}
		s_iTimeout = iTimeout;
	}

	/**
	 * Gets Sets the amount of time the test runner will wait for AsyncNotify.done() to be called before timing out.
	 * @return Int - the timeout in milliseconds
	 */
	public static function getTimeout() : Int
	{
		return s_iTimeout;
	}

	/**
	 * Call this method from asynchronous test methods when they are complete.
	 */
	public function done() : Void
	{
		if(!m_prom.isResolved())
		{
			m_deferred.resolve(true);
		}
		else
		{
			trace("warning -- Async.done() called more than once, or already timed out.");
		}

		if(m_timer != null)
		{
			m_timer.stop();
			m_timer = null;
		}
	}

	/**
	 * Helper method for calling asynchronous code while correctly handling any exceptions thrown. 
	 * @param - the method that will be called.
	 */
	public function async(fn:Void->Void) : Void
	{
		if(fn != null)
		{
			try 
			{
				fn();
			}
			catch(e:Dynamic)
			{
				var currTest = m_tc.currentTest;
				#if js
					currTest.error = "async exception thrown : " + e + ((e.message != null) ? " [" + e.message + "]" : "");
				#else
					currTest.error = "async exception thrown : " + e;
				#end

				currTest.success = false;
				currTest.exception = e;
				currTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());

				if (!m_deferred.promise().isResolved())
				{
					m_deferred.resolve(false);
				}
			}
		}
	}

} // End of AsyncNotify class
