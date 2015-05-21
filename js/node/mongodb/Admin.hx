package js.node.mongodb;

import haxe.extern.EitherType;
import js.node.mongodb.Callback.ResultCallback;
import js.node.mongodb.MongoDocument;
import js.node.mongodb.MongoOption.MongoAddUserOption;
import js.node.mongodb.MongoOption.MongoRemoveUserOption;
import js.node.mongodb.MongoOption.MongoCommandOption;
import js.node.mongodb.MongoError;

/**
 * Allows the user to access the admin functionality of MongoDB
 */
@:jsRequire("mongodb", "Admin")
extern class Admin
{
	/**
	 * Add a user to the database.
	 * @param username - the user name
	 * @param password - the password
	 * @param options - MongoAddUserOption struct
	 * @param callback - callback of type ResultCallback
	 */
	function addUser(username:String, password:String, options:MongoAddUserOption, callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Authenticate a user against the server.
	 * @param username - the user name
	 * @param password - the password
	 * @param callback - callback of type ResultCallback
	 */
	function authenticate(username:String, password:String, callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Retrieve the server information for the current instance of the db client.
	 * @param callback - callback of type ResultCallback
	 */
	function buildInfo(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Execute a command.
	 * @param command - the command hash
	 * @param options - MongoCommandOption struct
	 * @param callback - callback of type ResultCallback
	 */
	function command(command:Dynamic, options:MongoCommandOption, callback:ResultCallback<MongoDocument>) : Void;
	
	/**
	 * List the available databases.
	 * @param callback - callback of type ResultCallback
	 */
	function listDatabases(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Logout user from server, fire off on all connections and remove all auth info.
	 * @param callback - callback of type ResultCallback
	 */
	function logout(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Ping the MongoDB server and retrieve results.
	 * @param callback - callback of type ResultCallback
	 */
	function ping(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Retrieve the current profiling information for MongoDB.
	 * @param callback - callback of type ResultCallback
	 */
	function profilingInfo(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Retrieve the current profiling Level for MongoDB.
	 * @param callback - callback of type ResultCallback
	 */
	function profilingLevel(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Remove a user from a database.
	 * @param username - the user name
	 * @param options - MongoRemoveUserOption struct
	 * @param callback - callback of type ResultCallback
	 */
	function removeUser(username:String, options:MongoRemoveUserOption, callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Get ReplicaSet status.
	 * @param callback - callback of type ResultCallback
	 */
	function replSetGetStatus(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Retrieve the server information for the current instance of the db client.
	 * @param callback - callback of type ResultCallback
	 */
	function serverInfo(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Retrieve this db's server status.
	 * @param callback - callback of type ResultCallback
	 */
	function serverStatus(callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Set the current profiling level of MongoDB.
	 * @param level    - The new profiling level ('off', 'slow_only', 'all').
	 * @param callback - callback of type ResultCallback
	 */
	function setProfilingLevel(level:String, callback:ResultCallback<MongoDocument>) : Void;

	/**
	 * Validate an existing collection.
	 * @param  collectionName - The name of the collection to validate.
	 * @param  options        - Optional settings.
	 * @param callback - callback of type ResultCallback
	 */
	function validateCollection(collectionName:String, options:Dynamic, callback:ResultCallback<MongoDocument>) : Void;
	
} // End of Admin class