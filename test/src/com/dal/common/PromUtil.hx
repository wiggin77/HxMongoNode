package com.dal.common;

import promhx.Deferred;
import promhx.Promise;

typedef AsyncCall<P,T> = P->Promise<T>;
typedef AsyncCallResult<T> = {val:T, success:Bool, exp:Dynamic};

class PromUtil
{
	/**
	 * Private constructor.
	 */
	private function new()
	{
		// Cannot instantiate.  Use static methods.
	}

	/**
	 * Calls a series of asynchronous methods waiting for the previous to finish before starting 
	 * the next.  The results of each call are provided as an array via the returned Promise.
	 * 
	 * @param  param - optional parameter passed to each async method.
	 * @param  calls - an array of async methods, each of which returns a Promise
	 * @return Promise which resolves to an array of values, one for each async method call.
	 */
	public static function series<P,T>(param:P, calls:Array<AsyncCall<P,T>>) : Promise<Array<AsyncCallResult<T>>>
	{
		if(calls == null || calls.length == 0)
		{
			return Promise.promise([]);
		}

		var defResult = new Deferred<Array<AsyncCallResult<T>>>();
		var result = new Array<AsyncCallResult<T>>();
		var f = function(idx:Int, max:Int) {
			if(idx < max)
			{
				try
				{
					var p = calls[i](param);
					p.then(function(v:T) {
						result.push({val:v, success:p.isFulfilled(), exp:null});
						idx++;
						f(idx, max);
					});
				}
				catch(e:Dynamic)
				{
					result.push({val:null, success:false, exp:e});
				}
			}
			else 
			{
				defResult.resolve(result);
			}
		};

		f(0, calls.length);

		return defResult.promise();
	}


} // End of PromUtil class