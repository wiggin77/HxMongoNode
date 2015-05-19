package com.dal.mongotest;

import js.node.mongodb.MongoClient;
import js.node.mongodb.MongoDatabase;

class MongoTest
{
	public static function main() : Void
	{
		var test = new MongoTest();
		test.run();
	}

	private var 	m_strUsername:String;
	private var 	m_strPassword:String;

	private var 	m_strDBDomain:String;
	private var 	m_strDBPort:String;
	private var 	m_strDatabase:String;


	public function new()
	{
		m_strUsername = "testUser";
		m_strPassword = "test";

		m_strDBDomain = "localhost";
		m_strDBPort = "27017";
		m_strDatabase = "test";
	}

	private function run()
	{
		var creds = m_strUsername + ":" + m_strPassword;
		var url = "mongodb://" + creds + "@" + m_strDBDomain + ":" + m_strDBPort + "/" + m_strDatabase;

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
		}
	}

	private function onInsert(err:js.Error, result:Dynamic, db:MongoDatabase) : Void
	{
		onResult("insert", err, result);
		db.close(function(err,result){onResult("close", err, result);});
	}

	private function onResult(action:String, err:js.Error, result:Dynamic) : Void
	{
		trace(err == null ? action + " success" : action + " error:" + err);
	}
}
