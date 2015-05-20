package com.dal.mongotest;

import com.dal.mongotest.Config;
import js.node.mongodb.Admin;
import js.node.mongodb.MongoClient;
import js.node.mongodb.MongoCursor;
import js.node.mongodb.MongoDatabase;
import com.dal.common.unit.TestCase;
import com.dal.common.unit.AsyncNotify;
import js.node.mongodb.MongoError;

class TestAdmin extends TestCase
{
	private var 	m_db:MongoDatabase;


	public function new()
	{
		super();
	}

	/**
	 * Called before each test method. 
	 */
	public override function setup() : Void 
	{
		m_db = null;
	}

	/**
	 * Called after each test method.  
	 */
	public override function tearDown() : Void 
	{
		if(m_db != null)
		{
			trace("Closing the database.");
			m_db.close();
		}
	}

	/**
	 * Connects to the database.
	 */
	private function connect(an:AsyncNotify, callback:MongoError->MongoDatabase->AsyncNotify->Void) : Void
	{
		var url = Config.connectString();
		MongoClient.connect(url, function(err,db) {m_db=db; callback(err,db,an);});
	}

	@AsyncTest
	public function testBuildInfo(an:AsyncNotify)
	{
		connect(an, doBuildInfo);
	}

	private function doBuildInfo(err:MongoError, db:MongoDatabase, an:AsyncNotify) : Void
	{
		assertNull(err);
		assertNotNull(db);

		var admin:Admin = db.admin();

		assertNotNull(admin);

		admin.buildInfo(function(err,info){
			assertNull(err);
			trace("Build version: " + info.version);
			an.done();
		});
	}

}
