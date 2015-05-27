package js.node.mongodb;

import haxe.extern.EitherType;

/**
 * Specifically typed Mongo documents.
 */
typedef MongoDocument = Dynamic;

typedef MongoResult = Dynamic;

typedef BulkWriteOpResult = {insertCount:Int, matchedCount:Int, modifiedCount:Int, deletedCount:Int, upsertedCount:Int, 
							 insertedIds:Dynamic, upsertedIds:Dynamic, result:MongoResult};
