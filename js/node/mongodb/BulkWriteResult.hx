package js.node.mongodb;

// Typedefs specific to bulk write results.
//
typedef InsertedId = { index:Int, _id:String };
typedef UpsertedId = InsertedId;

typedef WriteError = { code:Int, index:Int, errmsg:String };
typedef WriteConcernError = { code:Int, errmsg:String };

typedef BulkResult = { ok:Bool,  writeErrors:Array<WriteError>,  writeConcernErrors:Array<WriteConcernError>,
                      insertedIds:Array<InsertedId>,  nInserted:Int,  nUpserted:Int,  nMatched:Int,
                      nModified:Int,  nRemoved:Int,  upserted:Array<UpsertedId> };


/**
 * Result of a BulkWrite operation.
 */
@:jsRequire("mongodb", "BulkWriteResult")
extern class BulkWriteResult
{
	var ok 			: Bool;	//	{boolean} did bulk operation correctly execute
	var nInserted 	: Int;	//	{number} number of inserted documents
	var nUpdated 	: Int;	//	{number} number of documents updated logically
	var nUpserted 	: Int;	//	{number} number of upserted documents
	var nModified 	: Int;	//	{number} number of documents updated physically on disk
	var nRemoved 	: Int;	//	{ number } number of removed documents

	/**
	 * Return an array of inserted ids.
	 */
	function getInsertedIds() : Array<InsertedId>;

	/**
	 * Retrieve lastOp if available.
	 */
	function getLastOp() : MongoDocument;

	/**
	 * Return raw internal result.
	 */
	function getRawResponse() : BulkResult;

	/**
	 * Return the upserted id at position index
	 * @param  index - the number of the upserted id to return, returns undefined if no result for passed in index
	 */
	function getUpsertedIdAt(index:Int) : UpsertedId;

	/**
	 * Return an array of upserted ids.
	 */
	function getUpsertedIds() : Array<UpsertedId>;

	/**
	 * Retrieve the write concern error if any.
	 */
	function getWriteConcernError() : WriteConcernError;

	/**
	 * Returns a specific write error object.
	 */
	function getWriteErrorAt() : WriteError;

	/**
	 * Returns the number of write errors off the bulk operation.
	 */
	function getWriteErrorCount() : Int;

	/**
	 * Retrieve all write errors.
	 */
	function getWriteErrors() : Array<WriteError>;

	/**
	 * Returns true if the bulk operation contains a write error.
	 */
	function hasWriteErrors() : Bool;

} // End of BulkWriteResultClass
