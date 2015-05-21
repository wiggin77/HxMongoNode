package js.node.mongodb;

import js.node.mongodb.AggregationCursor;
import js.node.mongodb.Callback.ResultCallback;
import js.node.mongodb.MongoDocument;
import js.node.mongodb.MongoDocument.WriteConcern;
import js.node.mongodb.MongoOption.MongoCollectionAggregateOption;
import js.node.mongodb.MongoOption.MongoCollectionBuildOption;
import js.node.mongodb.MongoOption.MongoCollectionOption;

/**
 * Embodies a MongoDB collection allowing for insert/update/remove/find 
 * and other command operation on that MongoDB collection.
 */
@:jsRequire("mongodb", "Collection")
extern class MongoCollection
{
	/**
	 * Get the collection name.
	 */
	var collectionname(default,null) : String;

	/**
	 * Get the full collection namespace.
	 */
	var namespace(default,null) : String;

	/**
	 * The current write concern values.
	 */
	var writeConcern(default,null) : WriteConcern;

	/**
	 * Get current index hint for collection.
	 */
	var hint(default,null) : MongoDocument;

	/**
	 * Execute an aggregation framework pipeline against the collection, needs MongoDB >= 2.2.
	 * @param  pipeline - Array containing all the aggregation framework commands for the execution.
	 * @param  options 	- Optional settings.
	 * @param  callback - result callback
	 * @return AggregationCursor or null
	 */
	function aggregate(pipeline:Array<MongoDocument>, options:MongoCollectionAggregateOption, callback:ResultCallback<MongoDocument>) : AggregationCursor;



	var insert						: Dynamic;
	var remove                      : Dynamic;
	var rename                      : Dynamic;
	var save                        : Dynamic;
	var update                      : Dynamic;
	var distinct                    : Dynamic;
	var count                       : Dynamic;
	var drop                        : Dynamic;
	var findAndModify               : Dynamic;
	var findAndRemove               : Dynamic;
	var find                        : Dynamic;
	var findOne                     : Dynamic;
	var createIndex                 : Dynamic;
	var ensureIndex                 : Dynamic;
	var indexInformation            : Dynamic;
	var dropIndex                   : Dynamic;
	var dropAllIndexes              : Dynamic;
	var reIndex                     : Dynamic;
	var mapReduce                   : Dynamic;
	var group                       : Dynamic;
	var options                     : Dynamic;
	var isCapped                    : Dynamic;
	var indexExists                 : Dynamic;
	var geoNear                     : Dynamic;
	var geoHaystackSearch           : Dynamic;
	var indexes                     : Dynamic;
	var stats                       : Dynamic;
	var initializeUnorderedBulkOp   : Dynamic;
	var initializeOrderedBulkOp     : Dynamic;
	var parallelCollectionScan      : Dynamic;
	
}