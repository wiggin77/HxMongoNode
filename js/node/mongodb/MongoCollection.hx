package js.node.mongodb;

import js.node.mongodb.AggregationCursor;
import js.node.mongodb.MongoCallback.BulkWriteOpCallback;
import js.node.mongodb.MongoCallback.CountCallback;
import js.node.mongodb.MongoCallback.ResultCallback;
import js.node.mongodb.MongoDocument.MongoDocument;
import js.node.mongodb.MongoOption.CollectionBulkWriteOption;
import js.node.mongodb.MongoOption.CollectionCountOption;
import js.node.mongodb.MongoOption.CollectionWriteConcern;
import js.node.mongodb.MongoOption.CollectionAggregateOption;
import js.node.mongodb.MongoOption.CollectionBuildOption;
import js.node.mongodb.MongoOption.CollectionOption;


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
	var writeConcern(default,null) : CollectionWriteConcern;

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
	function aggregate(pipeline:Array<MongoDocument>, options:CollectionAggregateOption, callback:ResultCallback) : AggregationCursor;

	/**
	 * Perform a bulkWrite operation without a fluent API.
	 * Legal operation types are
	 * 		{ insertOne: { document: { a: 1 } } }
	 * 		{ updateOne: { filter: {a:2}, update: {$set: {a:2}}, upsert:true } }
	 * 		{ updateMany: { filter: {a:2}, update: {$set: {a:2}}, upsert:true } }
	 * 		{ deleteOne: { filter: {c:1} } }
	 * 		{ deleteMany: { filter: {c:1} } }
	 * 		{ replaceOne: { filter: {c:3}, replacement: {c:4}, upsert:true}}
	 *
	 * @param  operations<MongoDocument> - Bulk operations to perform.
	 * @param  options                   - Optional settings.
	 * @param  callback                  - The command result callback
	 */
	function bulkWrite(operations:Array<MongoDocument>, options:CollectionBulkWriteOption, callback:BulkWriteOpCallback) : Void;

	/**
	 * Count number of matching documents in the db to a query.
	 * @param  query    - The query for the count.
	 * @param  options  - Optional settings.
	 * @param  callback - callback of type CountCallback.
	 */
	function count(query:MongoDocument, options:CollectionCountOption, callback:CountCallback) : Void;/**


	var insert						: Dynamic;
	var remove                      : Dynamic;
	var rename                      : Dynamic;
	var save                        : Dynamic;
	var update                      : Dynamic;
	var distinct                    : Dynamic;
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
