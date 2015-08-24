package com.dal.mongotest;

import com.dal.mongotest.Config;
import com.dal.common.unit.TestCase;
import com.dal.common.unit.AsyncNotify;
import js.node.mongoose.Error;
import js.node.mongoose.Mongoose;
import promhx.Deferred;
import promhx.Promise;

class TestMongoose extends TestCase
{
	private var 	m_an:AsyncNotify;
	private var 	m_mongoose:Mongoose;

	public function new()
	{
		super();
		m_an = null;
		m_mongoose = null;
	}

	@AsyncTest
	public function testStuff(an:AsyncNotify)
	{
		m_an = an;
		m_mongoose = new Mongoose();

		var p = doConnect();

		//p.then(onConnect).then(doInsert).then(onInsert)


	}

	private function doConnect() : Promise<Error>
	{
		var d = new Deferred();
		var url = "mongodb://" + Config.domain + ":" + Config.port + "/" + Config.database;
		var opts = { server: { auto_reconnect: false }, user:Config.username, pass:Config.password };

		trace("Attempting Mongoose connection to: " + url);
	    
		m_mongoose.connect(url, opts, function(err) {d.resolve(err);});
		return d.promise();
	}


	private function doInsert() : Promise<Error>
	{
		var d = new Deferred();

		// TODO.
		d.resolve(null);

		return d.promise();
	}


	private function onConnect(err:Error) : Void
	{
		var str = (err == null) ? "Connected to server." : "Error connecting to server: " + err;
		trace(str);
		assertNull(err);
	}


	public static function series<T>(calls:Array<Void->Promise<T>>) : Promise<T>
	{
		if(calls == null || calls.length == 0)
		{
			return Promise.promise(null);
		}

		var i = 0;
		var c = function() {
			var p = calls[i]();
			
		};

		
		// TODO
		return null;
	}






} // End of TestMongoose class
