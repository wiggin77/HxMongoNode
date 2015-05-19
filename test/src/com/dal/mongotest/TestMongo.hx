package com.dal.mongotest;

import com.dal.mongotest.Config;
import js.node.mongodb.MongoClient;
import js.node.mongodb.MongoCursor;
import js.node.mongodb.MongoDatabase;
import com.dal.common.unit.TestCase;
import com.dal.common.unit.AsyncNotify;

class TestMongo extends TestCase
{
	private var 	m_an:AsyncNotify;

	public function new()
	{
		super();
		m_an = null;
	}

	@AsyncTest
	public function testStuff(an:AsyncNotify)
	{
		m_an = an;

		var creds = Config.username + ":" + Config.password;
		var url = "mongodb://" + creds + "@" + Config.domain + ":" + Config.port + "/" + Config.database;

		trace("Attempting connection to: " + url);

		MongoClient.connect(url, onConnect);
		
	}

	private function onConnect(err:js.Error, db:MongoDatabase) : Void
	{
		if(err == null)
		{
			trace("Connected to server.");
			
			// Insert some records.
			var collection = db.collection("stuff", null);
			collection.insert([{a : 1}, {a : 2}, {a : 3}], function(err,result){onInsert(err,result,db); });
		}
		else 
		{
			trace("Error connecting to server: " + err);
			assertTrue(false);
			m_an.done();
		}
	}

	private function onInsert(err:js.Error, result:Dynamic, db:MongoDatabase) : Void
	{
		onResult("insert", err, result);

		assertEquals(err, null);

		// Update a collection.
		var collection = db.collection("stuff", null);
		collection.update({a:2}, {"$set":{b:1}}, function(err,result){onUpdate(err,result,db); });
	}

	private function onUpdate(err:js.Error, result:Dynamic, db:MongoDatabase) : Void
	{
		onResult("update", err, result);

		assertEquals(err, null);

		// Remove a document.
		var collection = db.collection("stuff", null);
		collection.remove({a:3}, function(err,result){onRemove(err,result,db);});
	}

	private function onRemove(err:js.Error, result:Dynamic, db:MongoDatabase) : Void
	{
		onResult("remove", err, result);

		assertEquals(err, null);

		// Find all documents
		var collection = db.collection("stuff", null);
		var cursor:MongoCursor = collection.find({});

		cursor.count(false, null, function(err,count){trace("Found " + count + " documents.");});
		cursor.toArray(function(err,docs){trace(docs); doClose(db);});
	}

	private function doClose(db:MongoDatabase) : Void
	{
		db.close(function(err,result){onClose(err, result);});
	}

	private function onClose(err:js.Error, result:Dynamic) : Void
	{
		onResult("remove", err, result);
		
		assertEquals(err, null);

		m_an.done();
	}

	private function onResult(action:String, err:js.Error, result:Dynamic) : Void
	{
		trace(err == null ? action + " success" : action + " error:" + err);
	}
}
