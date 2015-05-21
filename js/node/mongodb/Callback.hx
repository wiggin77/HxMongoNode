package js.node.mongodb;

/**
 * Typedefs for callbacks.
 */
typedef ResultCallback<T> = MongoError->T->Void;
typedef EndCallback = MongoError->Void;
typedef IteratorCallback<T> = T->Void;
typedef ToArrayCallback<T> = MongoError->Array<T>->Void;

