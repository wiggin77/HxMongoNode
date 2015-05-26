package js.node.mongodb;

import haxe.extern.EitherType;

typedef MongoDocument = Dynamic;

//
// Add any specifically typed documents (structs) here. 
//

typedef BulkWriteOpResult = {insertCount:Int, matchedCount:Int, modifiedCount:Int, deletedCount:Int, upsertedCount:Int, 
							 insertedIds:Dynamic, upsertedIds:Dynamic, result:MongoDocument};
