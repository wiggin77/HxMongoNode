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

import haxe.CallStack;
import haxe.PosInfos;

/**
 * Simple class to store test status for an individual test method.
 */
class TestStatus 
{
	public var done(get,set) : Bool;
	public var success(get,set) : Bool;
	public var timedOut(get,set) : Bool;
	public var error : String;
	public var method : String;
	public var classname : String;
	public var posInfos : PosInfos;
	public var backtrace : String;
	public var exception : Dynamic;

	/**
	 * flag for "done" property.
	 */
	private var m_bDone:Bool;

	/**
	 * flag for "success" property.
	 */
	private var m_bSuccess:Bool;

	/**
	 * flag for "timedOut" property.
	 */
	private var m_bTimedOut:Bool;

	/**
	 * Constructor
	 */
	public function new() 	
	{
		m_bDone = false;
		m_bSuccess = true;
		m_bTimedOut = false;
		exception = null;		
	}

	/**
	 * Getter for "done" property.
	 * @return Bool
	 */
	function get_done() : Bool
	{
		return m_bDone;
	}

	/**
	 * Setter for "done" property.
	 * @param bDone - new value
	 */
	function set_done(bDone:Bool) : Bool
	{
		m_bDone = bDone;
		return bDone;
	}

	/**
	 * xx_Atomically_xx gets the "done" property and sets it to a new value.
	 * @param  bDone - the new value
	 * @return Bool - the previous value
	 */
	public function getAndSetDone(bDone:Bool) : Bool
	{
		// Removed AtomicBool so we're not dependent on
		// my whole concurrency package.
		var bRet = m_bDone;
		m_bDone = bDone;
		return bRet;
	}

	/**
	 * Getter for "success" property.
	 * @return Bool
	 */
	function get_success() : Bool
	{
		return m_bSuccess;
	}

	/**
	 * Setter for "success" property.
	 * @param bSuccess - new value
	 */
	function set_success(bSuccess:Bool) : Bool
	{
		m_bSuccess = bSuccess;
		return bSuccess;
	}

	/**
	 * Getter for "timedOut" property.
	 * @return Bool
	 */
	function get_timedOut() : Bool
	{
		return m_bTimedOut;
	}

	/**
	 * Setter for "timedOut" property.
	 * @param bTimedOut - new value
	 */
	function set_timedOut(bTimedOut:Bool) : Bool
	{
		m_bTimedOut = bTimedOut;
		return bTimedOut;
	}

} // End of TestStatus class
