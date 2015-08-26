package com.dal.common;

import promhx.Deferred;
import promhx.Promise;

typedef SeriesResult<T> = {successes:Int, fails:Int, results:Array<AsyncCallResult<T>>};
typedef AsyncCall<P,T> = P->Promise<T>;
typedef AsyncCallResult<T> = {val:T, success:Bool, exp:Dynamic};
typedef AsyncCallState<P,T> = {idx:Int, param:P, sres:SeriesResult<T>, dres:Deferred<SeriesResult<T>>};

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
	 * @return Promise which resolves to a SeriesResult object.
	 */
	public static function series<P,T>(param:P, calls:Array<AsyncCall<P,T>>) : Promise<SeriesResult<T>>
	{
		var sResult:SeriesResult<T> = {successes:0, fails:0, results:new Array<AsyncCallResult<T>>()};

		if(calls == null || calls.length == 0)
		{
			return Promise.promise(sResult);
		}

		var defResult = new Deferred<SeriesResult<T>>();

		var state = {idx:0, param:param, sres:sResult, dres:defResult};

		seriesLoop(calls, state);

		return defResult.promise();
	}

	/**
	 * Helper method for series.
	 *
	 * @param  calls - an array of async methods, each of which returns a Promise
	 * @param  state - current state of the series of calls.
	 */
	private static function seriesLoop<P,T>(calls:Array<AsyncCall<P,T>>, state:AsyncCallState<P,T>) : Void
	{
		if(state.idx < calls.length)
		{
			try
			{
				var prom = calls[state.idx](state.param);

				prom.catchError(function(err) {
					state.sres.results.push({val:null, success:false, exp:err});
					state.sres.fails++;
					state.idx++;
					seriesLoop(calls, state);
				});
				
				prom.then(function(v:T) {
					state.sres.results.push({val:v, success:true, exp:null});
					state.sres.successes++;
					state.idx++;
					seriesLoop(calls, state);
				});
			}
			catch(e:Dynamic)
			{
				state.sres.results.push({val:null, success:false, exp:e});
				state.sres.fails++;
				state.idx++;
				seriesLoop(calls, state);
			}
		}
		else 
		{
			state.dres.resolve(state.sres);
		}
	}

} // End of PromUtil class