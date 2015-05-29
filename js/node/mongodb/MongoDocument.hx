package js.node.mongodb;

/**
 * Specifically typed Mongo documents.
 */
typedef MongoDocument = Dynamic;

typedef MongoResult = Dynamic;

typedef BulkWriteOpResult = {insertCount:Int, matchedCount:Int, modifiedCount:Int, deletedCount:Int, upsertedCount:Int,
							 insertedIds:Dynamic, upsertedIds:Dynamic, result:MongoResult};
