package js.node.mongodb;
import js.node.events.EventEmitter;
import js.node.mongodb.Admin;
import js.node.mongodb.MongoOption.MongoAuthOption;
import js.node.mongodb.MongoOption.CollectionFetchOption;
import js.node.mongodb.MongoOption.CollectionOption;
import js.node.mongodb.MongoOption.MongoCommandOption;
import js.node.mongodb.MongoOption.MongoCursorOption;
import js.node.mongodb.MongoOption.MongoDatabaseOption;
import js.node.mongodb.MongoOption.MongoIndexOption;
import js.node.mongodb.MongoOption.MongoStatsOption;
import js.node.mongodb.MongoOption.MongoAddUserOption;
import js.node.mongodb.MongoOption.MongoRemoveUserOption;

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:jsRequire("mongodb", "Db")
extern class MongoDatabase extends EventEmitter<MongoDatabase>
{
	/**
	 * ‘mongodb://localhost:27017/default’	Default URL
	 */
	static var DEFAULT_URL:String;
	
	/**
	 * Create a new Db instance.
	 */
	@:overload(function(p_name:String,p_server:MongoServer):Void{})
	function new(p_name:String, p_server:MongoServer, p_options:MongoDatabaseOption):Void;
	
	/**
	 * Initialize the database connection.
	 * @param	p_callback
	 */
	function open(p_callback:MongoError->MongoDatabase-> Void):Void;
	
	/**
	 * Create a new Db instance sharing the current socket connections.
	 * @param	p_name
	 * @return
	 */
	function db(p_name:String):MongoDatabase;
	
	/**
	 * Close the current db connection, including all the child db instances. Emits close event if no callback is provided.
	 * @param	p_force
	 * @param	p_callback
	 */
	@:overload(function():Void{})
	@:overload(function(p_callback : MongoError -> Dynamic -> Void):Void{})	
	function close(p_force:Bool, p_callback : MongoError -> Dynamic -> Void):Void;
	
	/**
	 * Access the Admin database
	 */
	function admin() : Admin;
	
	/**
	 * Returns a cursor to all the collection information.
	 * @param	p_name
	 * @param	p_callback
	 */
	@:overload(function(p_callback : MongoError -> Dynamic ->Void):MongoCursor { } )		
	function collectionsInfo(p_name:String, p_callback : MongoError -> Dynamic ->Void):MongoCursor;

	/**
	 * Get the list of all collection names for the specified db
	 * @param	p_name
	 * @param	p_options
	 * @param	p_callback
	 * @return
	 */
	@:overload(function (p_callback:MongoError->Array<String>->Void):Array<String> { } )
	@:overload(function (p_name:String, p_callback:MongoError->Array<String>->Void):Array<String> { } )
	function collectionNames(p_name:String, p_options : MongoDatabaseOption, p_callback:MongoError->Array<String>->Void):Array<String>;
	
	/**
	 * Fetch a specific collection (containing the actual collection information). 
	 * If the application does not use strict mode you can can use it without a callback in the following way.
	 * var collection = db.collection(‘mycollection’);
	 * @param	p_name
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_name:String,p_callback:MongoError->MongoCollection->Void):MongoCollection{})
	function collection(p_name:String, p_options : CollectionFetchOption, p_callback:MongoError->MongoCollection->Void):MongoCollection;
	
	/**
	 * Fetch all collections for the current db.
	 * @param	p_callback
	 */
	function collections(p_callback:MongoError->Array<MongoCollection>->Void):Void;
	
	/**
	 * Evaluate javascript on the server.
	 * @param	p_code
	 * @param	p_parameters
	 * @param	p_option
	 * @param	p_callback
	 */
	@:overload(function (p_code : String,p_callback:MongoError->Dynamic->Void):Void{})
	@:overload(function (p_code : String,p_parameters : Dynamic,p_callback:MongoError->Dynamic->Void):Void{})	
	function eval(p_code : String,p_parameters : Dynamic,p_option : MongoOption,p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Dereference a dbref, against a db
	 * @param	p_database_ref
	 * @param	p_callback
	 */
	function dereference(p_database_ref : MongoDatabaseRef, p_callback : MongoError->Bool->Void):Void;
	
	/**
	 * Logout user from server, fire off on all connections and remove all auth info
	 * @param	p_callback
	 */
	function logout(p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Authenticate a user against the server. authMechanism Options
	 * @param	p_username
	 * @param	p_password
	 * @param	p_options
	 * @param	p_callback
	 */	
	@:overload(function (p_username:String,p_password:String,p_callback:MongoError->Bool->Void):Void{})
	function authenticate(p_username:String,p_password:String,p_options:MongoAuthOption,p_callback:MongoError->Bool->Void):Void;
	
	
	/**
	 * Add a user to the database.
	 * @param	p_username
	 * @param	p_password
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_username:String,p_password:String,p_callback:MongoError->Dynamic->Void):Void{})	
	function addUser(p_username:String, p_password:String, p_options:MongoAddUserOption, p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Remove a user from a database
	 * @param	p_username
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_username:String,p_callback:MongoError->Bool->Void):Void{})	
	function removeUser(p_username:String, p_options:MongoRemoveUserOption, p_callback:MongoError->Bool->Void):Void;
	
	/**
	 * Creates a collection on a server pre-allocating space, need to create f.ex capped collections.
	 * @param	p_name
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_name:String,  p_callback:MongoError->MongoCollection->Void):Void{})	
	function createCollection(p_name:String, p_options:CollectionOption, p_callback:MongoError->MongoCollection->Void):Void;
	
	/**
	 * Execute a command hash against MongoDB. This lets you acess any commands not available through the api on the server.
	 * @param	p_selector
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_selector:Dynamic,p_callback:MongoError->Dynamic->Void):Void{})	
	function command(p_selector:Dynamic,p_options:MongoCommandOption,p_callback:MongoError->Dynamic->Void):Void;
	
	//Drop a collection from the database, removing it permanently. New accesses will create a new collection.
	function dropCollection(p_name:String, p_callback:MongoError->Bool->Void):Void;
	
	/**
	 * Rename a collection.
	 * @param	p_from
	 * @param	p_to
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_from : String, p_to:String, p_callback:MongoError->MongoCollection->Void):Void{})
	function renameCollection(p_from : String, p_to:String, p_options:CollectionOption, p_callback:MongoError->MongoCollection->Void):Void;
	
	/**
	 * Creates an index on the collection.
	 * @param	p_collection
	 * @param	p_field_or_spec
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_collection_name:String, p_field_or_spec:Dynamic,p_callback:MongoError->Dynamic->Void):Void{})	
	function createIndex(p_collection_name:String, p_field_or_spec:Dynamic,p_options:MongoIndexOption, p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Ensures that an index exists, if it does not it creates it
	 * @param	p_collection
	 * @param	p_field_or_spec
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_collection_name:String, p_field_or_spec:Dynamic,p_callback:MongoError->Dynamic->Void):Void{})		
	function ensureIndex(p_collection_name:String, p_field_or_spec:Dynamic, p_options:MongoIndexOption, p_callback:MongoError->Dynamic->Void):Void;
	
	
	/**
	 * Reindex all indexes on the collection 
	 * Warning: reIndex is a blocking operation (indexes are rebuilt in the foreground) and will be slow for large collections.
	 * @param	p_collection_name
	 * @param	p_callback
	 */
	function reIndex(p_collection_name:String,p_callback:MongoError->Bool->Void):Void;
	
	
	/**
	 * Retrieves this collections index info.
	 * @param	p_collection_name
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_collection_name:String,p_callback:MongoError->Dynamic->Void):Void{})
	function indexInformation(p_collection_name:String,p_options:MongoIndexOption,p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Drop an index on a collection.
	 * @param	p_collection_name
	 * @param	p_index_name
	 * @param	p_callback
	 */
	function dropIndex(p_collection_name:String,p_index_name:String,p_callback:MongoError->Bool->Void):Void;
	
	
	/**
	 * Returns the information available on allocated cursors.
	 * TODO: trace(callback 'infor' parameter)
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_callback:MongoError->Dynamic->Void):Void{})
	function cursorInfo(p_options : MongoCursorOption, p_callback:MongoError->Dynamic->Void):Void;
	
	/**
	 * Drop a database.
	 * @param	p_callback
	 */
	function dropDatabase(p_callback:MongoError->Bool->Void):Void;
	
	/**
	 * Get all the db statistics.
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_callback:MongoError->Dynamic->Void):Void{})
	function stats(p_options:MongoStatsOption,p_callback:MongoError->Dynamic->Void):Void;
	
}