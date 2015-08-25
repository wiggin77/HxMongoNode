package com.dal.mongotest;

import com.dal.common.PromUtil;
import com.dal.common.PromUtil.AsyncCall;
import com.dal.common.PromUtil.AsyncCallResult;
import com.dal.mongotest.Config;
import com.dal.common.unit.TestCase;
import com.dal.common.unit.AsyncNotify;
import promhx.Deferred;
import promhx.Promise;

typedef JobState = {count:Int};
typedef JobResult = {ts:Date};

class TestPromUtil extends TestCase
{

	public function new()
	{
		super();
	}

	override public function setup() : Void 
	{
		trace("Setting timeout to 30s");
		AsyncNotify.setTimeout(30000);
	}


	@AsyncTest
	public function testProm(an:AsyncNotify)
	{
		var calls:Array<AsyncCall<JobState,JobResult>> = [doJob1, doJob2_exp, doJob3, doJob4_reject, doJob5];

		var p = PromUtil.series({count:0}, calls);

		p.then(function(sres) {
			trace(sres);
			assertTrue(sres.results.length == 5);
			assertTrue(sres.successes == 3);
			assertTrue(sres.fails == 2);
			an.done();
		});
	}

	private function doJob1(state:JobState) : Promise<JobResult>
	{
		var d = new Deferred<JobResult>();

		haxe.Timer.delay(function() {
			state.count++;
			trace("doJob1 - counter:" + state.count);
			d.resolve({ts:Date.now()});
		}, 3000);

		return d.promise();
	}

	private function doJob2_exp(state:JobState) : Promise<JobResult>
	{
		var d = new Deferred<JobResult>();

		haxe.Timer.delay(function() {
			state.count++;
			trace("doJob2_exp - counter:" + state.count);
			d.resolve({ts:Date.now()});
		}, 3000);

		if(3==3)
		{
			throw "Whoops";
		}

		return d.promise();
	}

	private function doJob3(state:JobState) : Promise<JobResult>
	{
		var d = new Deferred<JobResult>();

		haxe.Timer.delay(function() {
			state.count++;
			trace("doJob3 - counter:" + state.count);
			d.resolve({ts:Date.now()});
		}, 3000);

		return d.promise();
	}

	private function doJob4_reject(state:JobState) : Promise<JobResult>
	{
		var d = new Deferred<JobResult>();
		var p = d.promise();

		haxe.Timer.delay(function() {
			state.count++;
			trace("doJob4_reject - counter:" + state.count);
			p.reject("rejected!");
		}, 3000);

		return p;
	}

	private function doJob5(state:JobState) : Promise<JobResult>
	{
		var d = new Deferred<JobResult>();

		haxe.Timer.delay(function() {
			state.count++;
			trace("doJob5 - counter:" + state.count);
			d.resolve({ts:Date.now()});
		}, 3000);

		return d.promise();
	}

} // End of TestPromUtil class
