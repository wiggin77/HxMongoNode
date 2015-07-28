package js.node.mongoose;

@:jsRequire("mongoose", "Model")
extern class Model
{
	public var db : Connection;
	public var collection : Dynamic; // Really a MongoCollection
	public var modelName : String;

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
	public function new(doc:Dynamic, fields:Dynamic, skipId:Bool);

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
	public function save(?options:Dynamic, ?fn:Error->Dynamic->Int->Void) : Promise;

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



} // End of Model class