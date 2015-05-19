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

import haxe.PosInfos;

/**
 * Base class for all test cases.
 */
@:keepSub
class TestCase #if mt_build implements mt.Protect #end 
{
	/**
	 * The current test status.
	 */
	@:allow(com.dal.common.unit)
	private var currentTest : TestStatus;

	/**
	 * Constructor
	 */
	public function new( ) 
	{
		// Do nothing.
	}

	/**
	 * Called before each test method.  Override in derived classes to perform per test method initialization.
	 */
	public function setup() : Void 
	{
	}

	/**
	 * Called after each test method.  Override in derived classes to perform per test method cleanup.
	 */
	public function tearDown() : Void 
	{
	}

	/**
	 * Prints the specified object using TestRunner.print.
	 * @param	v - the object to print.
	 */
	public function print( v : Dynamic ) 
	{
		haxe.unit.TestRunner.print(v);
	}

	/**
	 * Asserts that the expression b is true, otherwise an exception is thrown.
	 * @param	b - the expression to evaluate.
	 * @param	c - the optional position info.
	 */
	public function assertTrue( b:Bool, ?c : PosInfos ) : Void 
	{
		currentTest.done = true;
		if (b == false && currentTest.success != false)
		{
			currentTest.success = false;
			currentTest.error   = "expected true but was false";
			currentTest.posInfos = c;
			try
			{
				throw currentTest;
			}
			catch ( e : TestStatus )
			{
				currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
			}
		}
	}

	/**
	 * Asserts that the expression b is false, otherwise an exception is thrown.
	 * @param	b - the expression to evaluate.
	 * @param	c - the optional position info.
	 */
	public function assertFalse( b:Bool, ?c : PosInfos ) : Void 
	{
		currentTest.done = true;
		if (b == true  && currentTest.success != false)
		{
			currentTest.success = false;
			currentTest.error   = "expected false but was true";
			currentTest.posInfos = c;
			try
			{
				throw currentTest;
			}
			catch ( e : TestStatus )
			{
				currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
			}
		}
	}

	/**
	 * Asserts that the expressions 'expected' and 'actual' are equal, otherwise an exception is thrown.
	 * @param	expected - expected value
	 * @param	actual - value to compare with 'expected'
	 * @param	c - the optional position info.
	 */
	public function assertEquals<T>( expected: T , actual: T,  ?c : PosInfos ) : Void 	
	{
		currentTest.done = true;
		if (actual != expected && currentTest.success != false)
		{
			currentTest.success = false;
			currentTest.error   = "expected '" + expected + "' but was '" + actual + "'";
			currentTest.posInfos = c;
			try
			{
				throw currentTest;
			}
			catch ( e : TestStatus )
			{
				currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
			}
		}
	}

} // End of TestCase class
