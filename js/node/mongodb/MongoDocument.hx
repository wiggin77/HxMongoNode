package js.node.mongodb;

import haxe.extern.EitherType;

typedef MongoDocument = Dynamic;

//
// Add any specifically typed documents (structs) here. 
//

typedef WriteConcern = { w:EitherType<String,EitherType<Int,MongoDocument>>, j:Bool, fsync:Bool, wtimeout:Int };
