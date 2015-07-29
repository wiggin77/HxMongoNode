package js.node.mongoose;

import haxe.ds.Either;
import js.node.mongodb.MongoCollection;

typedef Id = {Either<String,Either<Int,{}>>};

@:jsRequire("mongoose", "Model")
extern class Model
{
	public var db(default,null) : Connection;
	public var collection(default,null) : MongoCollection;
	public var modelName(default,null) : String;
	public var schema(default,null) : Schema;
	public var base(default,null) : Mongoose;

	/**
	 * Model constructor
	 *
	 * Provides the interface to MongoDB collections as well as creates document instances.
	 *
	 * @param {Object} doc values with which to create the document
	 * @inherits Document
	 * @event `error`: If listening to this event, it is emitted when a document was saved without passing a callback and an `error` occurred. If not listening, the event bubbles to the connection used to create this Model.
	 * @event `index`: Emitted after `Model#ensureIndexes` completes. If an error occurred it is passed with the event.
	 * @api public
	 */
	public function new(doc:{}}, fields:{}}, skipId:Bool);

	/**
	 * Saves this document.
	 *
	 * ####Example:
	 *
	 *     product.sold = Date.now();
	 *     product.save(function (err, product, numberAffected) {
	 *       if (err) ..
	 *     })
	 *
	 * The callback will receive three parameters, `err` if an error occurred, `product` which is the saved `product`, and `numberAffected` which will be 1 when the document was found and updated in the database, otherwise 0.
	 *
	 * The `fn` callback is optional. If no `fn` is passed and validation fails, the validation error will be emitted on the connection used to create this model.
	 * ####Example:
	 *     var db = mongoose.createConnection(..);
	 *     var schema = new Schema(..);
	 *     var Product = db.model('Product', schema);
	 *
	 *     db.on('error', handleError);
	 *
	 * However, if you desire more local error handling you can add an `error` listener to the model and handle errors there instead.
	 * ####Example:
	 *     Product.on('error', handleError);
	 *
	 * As an extra measure of flow control, save will return a Promise (bound to `fn` if passed) so it could be chained, or hook to recive errors
	 * ####Example:
	 *     product.save().then(function (product, numberAffected) {
	 *        ...
	 *     }).onRejected(function (err) {
	 *        assert.ok(err)
	 *     })
	 *
	 * For legacy reasons, mongoose stores object keys in reverse order on initial save. That is, `{ a: 1, b: 2 }` will be saved as `{ b: 2, a: 1 }` in MongoDB. To override this behavior, set [the `toObject.retainKeyOrder` option](http://mongoosejs.com/docs/api.html#document_Document-toObject) to true on your schema.
	 *
	 * @param {Object} [options] options set `options.safe` to override [schema's safe option](http://mongoosejs.com//docs/guide.html#safe)
	 * @param {function(err, document, Number)} [fn] optional callback
	 * @return {Promise} Promise
	 * @api public
	 * @see middleware http://mongoosejs.com/docs/middleware.html
	 */
	public function save(?options:{}}, ?fn:Error->Model->Int->Void) : Promise;

	/**
	 * Signal that we desire an increment of this documents version.
	 *
	 * ####Example:
	 *
	 *     Model.findById(id, function (err, doc) {
	 *       doc.increment();
	 *       doc.save(function (err) { .. })
	 *     })
	 *
	 * @see versionKeys http://mongoosejs.com/docs/guide.html#versionKey
	 * @api public
	 */
	public function increment() : Model;

	/**
	 * Removes this document from the db.
	 *
	 * ####Example:
	 *     product.remove(function (err, product) {
	 *       if (err) return handleError(err);
	 *       Product.findById(product._id, function (err, product) {
	 *         console.log(product) // null
	 *       })
	 *     })
	 *
	 *
	 * As an extra measure of flow control, remove will return a Promise (bound to `fn` if passed) so it could be chained, or hooked to recive errors
	 *
	 * ####Example:
	 *     product.remove().then(function (product) {
	 *        ...
	 *     }).onRejected(function (err) {
	 *        assert.ok(err)
	 *     })
	 *
	 * @param {function(err,product)} [fn] optional callback
	 * @return {Promise} Promise
	 * @api public
	 */
	public function remove(?options:{}, ?fn:Error->{}->Void) : Promise;


	/**
	 * Returns another Model instance.
	 *
	 * ####Example:
	 *
	 *     var doc = new Tank;
	 *     doc.model('User').findById(id, callback);
	 *
	 * @param {String} name model name
	 * @api public
	 */
	public function model(name:String) : Model;

	/**
	 * Adds a discriminator type.
	 *
	 * ####Example:
	 *
	 *     function BaseSchema() {
	 *       Schema.apply(this, arguments);
	 *
	 *       this.add({
	 *         name: String,
	 *         createdAt: Date
	 *       });
	 *     }
	 *     util.inherits(BaseSchema, Schema);
	 *
	 *     var PersonSchema = new BaseSchema();
	 *     var BossSchema = new BaseSchema({ department: String });
	 *
	 *     var Person = mongoose.model('Person', PersonSchema);
	 *     var Boss = Person.discriminator('Boss', BossSchema);
	 *
	 * @param {String} name   discriminator model name
	 * @param {Schema} schema discriminator model schema
	 * @api public
	 */

	public function discriminator(name:String, schema:Schema) : Model;

	/**
	 * Sends `ensureIndex` commands to mongo for each index declared in the schema.
	 *
	 * ####Example:
	 *
	 *     Event.ensureIndexes(function (err) {
	 *       if (err) return handleError(err);
	 *     });
	 *
	 * After completion, an `index` event is emitted on this `Model` passing an error if one occurred.
	 *
	 * ####Example:
	 *
	 *     var eventSchema = new Schema({ thing: { type: 'string', unique: true }})
	 *     var Event = mongoose.model('Event', eventSchema);
	 *
	 *     Event.on('index', function (err) {
	 *       if (err) console.error(err); // error occurred during index creation
	 *     })
	 *
	 * _NOTE: It is not recommended that you run this in production. Index creation may impact database performance depending on your load. Use with caution._
	 *
	 * The `ensureIndex` commands are not sent in parallel. This is to avoid the `MongoError: cannot add index with a background operation in progress` error. See [this ticket](https://github.com/Automattic/mongoose/issues/1365) for more information.
	 *
	 * @param {Function} [cb] optional callback
	 * @return {Promise}
	 * @api public
	 */
	public function ensureIndexes(?cb:Error->Void) : Promise;

	/**
	 * Finds documents
	 *
	 * The `conditions` are cast to their respective SchemaTypes before the command is sent.
	 *
	 * ####Examples:
	 *
	 *     // named john and at least 18
	 *     MyModel.find({ name: 'john', age: { $gte: 18 }});
	 *
	 *     // executes immediately, passing results to callback
	 *     MyModel.find({ name: 'john', age: { $gte: 18 }}, function (err, docs) {});
	 *
	 *     // name LIKE john and only selecting the "name" and "friends" fields, executing immediately
	 *     MyModel.find({ name: /john/i }, 'name friends', function (err, docs) { })
	 *
	 *     // passing options
	 *     MyModel.find({ name: /john/i }, null, { skip: 10 })
	 *
	 *     // passing options and executing immediately
	 *     MyModel.find({ name: /john/i }, null, { skip: 10 }, function (err, docs) {});
	 *
	 *     // executing a query explicitly
	 *     var query = MyModel.find({ name: /john/i }, null, { skip: 10 })
	 *     query.exec(function (err, docs) {});
	 *
	 *     // using the promise returned from executing a query
	 *     var query = MyModel.find({ name: /john/i }, null, { skip: 10 });
	 *     var promise = query.exec();
	 *     promise.addBack(function (err, docs) {});
	 *
	 * @param {Object} conditions
	 * @param {Object} [projection] optional fields to return (http://bit.ly/1HotzBo)
	 * @param {Object} [options] optional
	 * @param {Function} [callback]
	 * @return {Query}
	 * @see field selection #query_Query-select
	 * @see promise #promise-js
	 * @api public
	 */
	@:overload(function (conditions:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}, options:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}, callback:Error->{}) : Query {});
	@:overload(function (conditions:{}, callback:Error->{}) : Query {});
	public function find(conditions:{}, projection:{}, options:{}, callback:Error->{}->Void) : Query;

	/**
	 * Finds a single document by its _id field. `findById(id)` is equivalent to
	 * `findOne({ _id: id })`.
	 *
	 * The `id` is cast based on the Schema before sending the command.
	 *
	 * ####Example:
	 *
	 *     // find adventure by id and execute immediately
	 *     Adventure.findById(id, function (err, adventure) {});
	 *
	 *     // same as above
	 *     Adventure.findById(id).exec(callback);
	 *
	 *     // select only the adventures name and length
	 *     Adventure.findById(id, 'name length', function (err, adventure) {});
	 *
	 *     // same as above
	 *     Adventure.findById(id, 'name length').exec(callback);
	 *
	 *     // include all properties except for `length`
	 *     Adventure.findById(id, '-length').exec(function (err, adventure) {});
	 *
	 *     // passing options (in this case return the raw js objects, not mongoose documents by passing `lean`
	 *     Adventure.findById(id, 'name', { lean: true }, function (err, doc) {});
	 *
	 *     // same as above
	 *     Adventure.findById(id, 'name').lean().exec(function (err, doc) {});
	 *
	 * @param {Object|String|Number} id value of `_id` to query by
	 * @param {Object} [projection] optional fields to return (http://bit.ly/1HotzBo)
	 * @param {Object} [options] optional
	 * @param {Function} [callback]
	 * @return {Query}
	 * @see field selection #query_Query-select
	 * @see lean queries #query_Query-lean
	 * @api public
	 */
	@:overload(function (id:Id) : Query {});
	@:overload(function (id:Id, projection:{}) : Query {});
	@:overload(function (id:Id, projection:{}, options:{}) : Query {});
	@:overload(function (id:Id, projection:{}, callback:Error->{}) : Query {});
	@:overload(function (id:Id, callback:Error->{}) : Query {});
	public function findById(id:Id, projection:{}, options:{}, callback:Error->{}->Void) : Query;

	/**
	 * Finds one document.
	 *
	 * The `conditions` are cast to their respective SchemaTypes before the command is sent.
	 *
	 * ####Example:
	 *
	 *     // find one iphone adventures - iphone adventures??
	 *     Adventure.findOne({ type: 'iphone' }, function (err, adventure) {});
	 *
	 *     // same as above
	 *     Adventure.findOne({ type: 'iphone' }).exec(function (err, adventure) {});
	 *
	 *     // select only the adventures name
	 *     Adventure.findOne({ type: 'iphone' }, 'name', function (err, adventure) {});
	 *
	 *     // same as above
	 *     Adventure.findOne({ type: 'iphone' }, 'name').exec(function (err, adventure) {});
	 *
	 *     // specify options, in this case lean
	 *     Adventure.findOne({ type: 'iphone' }, 'name', { lean: true }, callback);
	 *
	 *     // same as above
	 *     Adventure.findOne({ type: 'iphone' }, 'name', { lean: true }).exec(callback);
	 *
	 *     // chaining findOne queries (same as above)
	 *     Adventure.findOne({ type: 'iphone' }).select('name').lean().exec(callback);
	 *
	 * @param {Object} [conditions]
	 * @param {Object} [projection] optional fields to return (http://bit.ly/1HotzBo)
	 * @param {Object} [options] optional
	 * @param {Function} [callback]
	 * @return {Query}
	 * @see field selection #query_Query-select
	 * @see lean queries #query_Query-lean
	 * @api public
	 */
	@:overload(function (conditions:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}, options:{}) : Query {});
	@:overload(function (conditions:{}, projection:{}, callback:Error->{}) : Query {});
	@:overload(function (conditions:{}, callback:Error->{}) : Query {});
	public function findOne(conditions:{}, projection:{}, options:{}, callback:Error->{}->Void) {

	/**
	 * Counts number of matching documents in a database collection.
	 *
	 * ####Example:
	 *
	 *     Adventure.count({ type: 'jungle' }, function (err, count) {
	 *       if (err) ..
	 *       console.log('there are %d jungle adventures', count);
	 *     });
	 *
	 * @param {Object} conditions
	 * @param {Function} [callback]
	 * @return {Query}
	 * @api public
	 */
	public function count(?conditions:{}, ?callback:Error->Int->Void) : Query;

	/**
	 * Creates a Query for a `distinct` operation.
	 *
	 * Passing a `callback` immediately executes the query.
	 *
	 * ####Example
	 *
	 *     Link.distinct('url', { clicks: {$gt: 100}}, function (err, result) {
	 *       if (err) return handleError(err);
	 *
	 *       assert(Array.isArray(result));
	 *       console.log('unique urls with more than 100 clicks', result);
	 *     })
	 *
	 *     var query = Link.distinct('url');
	 *     query.exec(callback);
	 *
	 * @param {String} field
	 * @param {Object} [conditions] optional
	 * @param {Function} [callback]
	 * @return {Query}
	 * @api public
	 */
	public function distinct(field:String, ?conditions:{}, ?callback:Error->Array<{}>->Void) : Query;

	/**
	 * Creates a Query, applies the passed conditions, and returns the Query.
	 *
	 * For example, instead of writing:
	 *
	 *     User.find({age: {$gte: 21, $lte: 65}}, callback);
	 *
	 * we can instead write:
	 *
	 *     User.where('age').gte(21).lte(65).exec(callback);
	 *
	 * Since the Query class also supports `where` you can continue chaining
	 *
	 *     User
	 *     .where('age').gte(21).lte(65)
	 *     .where('name', /^b/i)
	 *     ... etc
	 *
	 * @param {String} path
	 * @param {Object} [val] optional value
	 * @return {Query}
	 * @api public
	 */
	public function where(path:String, ?val:Dynamic) : Query;

	/**
	 * Issues a mongodb findAndModify update command.
	 *
	 * Finds a matching document, updates it according to the `update` arg, passing any `options`, and returns the found document (if any) to the callback. 
	 * The query executes immediately if `callback` is passed else a Query object is returned.
	 *
	 * ####Options:
	 *
	 * - `new`: bool - if true, return the modified document rather than the original. defaults to false (changed in 4.0)
	 * - `upsert`: bool - creates the object if it doesn't exist. defaults to false.
	 * - `sort`: if multiple docs are found by the conditions, sets the sort order to choose which doc to update
	 * - `select`: sets the document fields to return
	 *
	 * ####Examples:
	 *
	 *     A.findOneAndUpdate(conditions, update, options, callback) // executes
	 *     A.findOneAndUpdate(conditions, update, options)  // returns Query
	 *     A.findOneAndUpdate(conditions, update, callback) // executes
	 *     A.findOneAndUpdate(conditions, update)           // returns Query
	 *     A.findOneAndUpdate()                             // returns Query
	 *
	 * ####Note:
	 *
	 * All top level update keys which are not `atomic` operation names are treated as set operations:
	 *
	 * ####Example:
	 *
	 *     var query = { name: 'borne' };
	 *     Model.findOneAndUpdate(query, { name: 'jason borne' }, options, callback)
	 *
	 *     // is sent as
	 *     Model.findOneAndUpdate(query, { $set: { name: 'jason borne' }}, options, callback)
	 *
	 * This helps prevent accidentally overwriting your document with `{ name: 'jason borne' }`.
	 *
	 * ####Note:
	 *
	 * Although values are cast to their appropriate types when using the findAndModify helpers, the following are *not* applied:
	 *
	 * - defaults
	 * - setters
	 * - validators
	 * - middleware
	 *
	 * If you need those features, use the traditional approach of first retrieving the document.
	 *
	 *     Model.findOne({ name: 'borne' }, function (err, doc) {
	 *       if (err) ..
	 *       doc.name = 'jason borne';
	 *       doc.save(callback);
	 *     })
	 *
	 * @param {Object} [conditions]
	 * @param {Object} [update]
	 * @param {Object} [options]
	 * @param {Function} [callback]
	 * @return {Query}
	 * @see mongodb http://www.mongodb.org/display/DOCS/findAndModify+Command
	 * @api public
	 */
	@:overload(function (conditions:{}, update:{}, options:{}) : Query {});
	@:overload(function (conditions:{}, update:{}, callback:Error->{}->Void);
	@:overload(function (conditions:{}, update:{}) : Query {});
	public function findOneAndUpdate(conditions:{}, update:{}, options:{}, callback:Error->{}->Void) : Query;


} // End of Model class