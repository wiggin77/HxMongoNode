package js.node.mongodb;

import js.node.mongodb.MongoError;
import js.node.mongodb.MongoDocument.MongoResult;
import js.node.mongodb.MongoDocument.BulkWriteOpResult;

/**
 * Typedefs for callbacks.
 */
typedef ResultCallback = MongoError->MongoResult->Void;
typedef EndCallback = MongoError->Void;
typedef IteratorCallback<T> = T->Void;
typedef ToArrayCallback<T> = MongoError->Array<T>->Void;

typedef BulkWriteOpCallback = MongoError->BulkWriteOpResult->Void;

typedef CountCallback = MongoError->Int->Void;