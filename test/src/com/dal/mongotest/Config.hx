package com.dal.mongotest;

class Config
{
	public static inline var 	username  	= "testUser";
	public static inline var 	password  	= "test";

	//public static inline var 	domain 		= "192.168.1.83"; 
	public static inline var 	domain 		= "localhost";

	public static inline var 	port  		= "27017";
	public static inline var 	database  	= "test";


	private function new()
	{
		// Don't instantiate.
	}

	/**
	 * Return the MongoDB connection string.
	 * @return [description]
	 */
	public static function connectString() : String
	{
		var creds = "";
		if(hasChars(username) || hasChars(password))
		{
			creds = username + ":" + password + "@";
		}
		var p = "";
		if(hasChars(port))
		{
			p = ":" + port;
		}
		var db = "";
		if(hasChars(database))
		{
			db = "/" + database;
		}

		return "mongodb://" + creds + domain + p + db;
	}

	/**
	 * Returns true if the string is not null and has at least one character.
	 */
	private static inline function hasChars(str:String) : Bool
	{
		return (str != null && str.length > 0);
	}

} 
