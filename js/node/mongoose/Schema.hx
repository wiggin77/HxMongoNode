package js.node.mongoose;

import js.node.events.EventEmitter;

typedef SchemaOptions = {
	?strict : Bool,
	?bufferCommands : Bool,
	?capped : Bool, // { size, max, autoIndexId }
	?versionKey : String,
	?discriminatorKey : String,
	?minimize : Bool,
	?autoIndex : Bool,
	?shardKey : Bool,
	?read : js.node.mongodb.ReadPreference,
	?validateBeforeSave : Bool,
	// the following are only applied at construction time
	?_id : Bool,
	?id : Bool
}


@:jsRequire("mongoose", "Schema")
extern class Schema extends EventEmitter<Schema>
{
	/**
	 * Schema constructor.
	 *
	 * ####Example:
	 *
	 *     var child = new Schema({ name: String });
	 *     var schema = new Schema({ name: String, age: Number, children: [child] });
	 *     var Tree = mongoose.model('Tree', schema);
	 *
	 *     // setting schema options
	 *     new Schema({ name: String }, { _id: false, autoIndex: false })
	 *
	 * ####Options:
	 *
	 * - [autoIndex](/docs/guide.html#autoIndex): bool - defaults to null (which means use the connection's autoIndex option)
	 * - [bufferCommands](/docs/guide.html#bufferCommands): bool - defaults to true
	 * - [capped](/docs/guide.html#capped): bool - defaults to false
	 * - [collection](/docs/guide.html#collection): string - no default
	 * - [id](/docs/guide.html#id): bool - defaults to true
	 * - [_id](/docs/guide.html#_id): bool - defaults to true
	 * - `minimize`: bool - controls [document#toObject](#document_Document-toObject) behavior when called manually - defaults to true
	 * - [read](/docs/guide.html#read): string
	 * - [safe](/docs/guide.html#safe): bool - defaults to true.
	 * - [shardKey](/docs/guide.html#shardKey): bool - defaults to `null`
	 * - [strict](/docs/guide.html#strict): bool - defaults to true
	 * - [toJSON](/docs/guide.html#toJSON) - object - no default
	 * - [toObject](/docs/guide.html#toObject) - object - no default
	 * - [validateBeforeSave](/docs/guide.html#validateBeforeSave) - bool - defaults to `true`
	 * - [versionKey](/docs/guide.html#versionKey): bool - defaults to "__v"
	 *
	 * ####Note:
	 *
	 * _When nesting schemas, (`children` in the example above), always declare the child schema first before passing it into its parent._
	 *
	 * @param {Object} definition
	 * @inherits NodeJS EventEmitter http://nodejs.org/api/events.html#events_class_events_eventemitter
	 * @event `init`: Emitted after the schema is compiled into a `Model`.
	 * @api public
	 */
	public function new(definition:{}, ?options:SchemaOptions);

	/**
	 * Returns default options for this schema, merged with `options`.
	 *
	 * @param {Object} options
	 * @return {Object}
	 * @api private
	 */
	 public function defaultOptions(?options:SchemaOptions) : SchemaOptions;

	/**
	 * Adds key path / schema type pairs to this schema.
	 *
	 * ####Example:
	 *
	 *     var ToySchema = new Schema;
	 *     ToySchema.add({ name: 'string', color: 'string', price: 'number' });
	 *
	 * @param {Object} obj
	 * @param {String} prefix
	 * @api public
	 */

	public function add(obj:{}, ?prefix:String) : Void;	 

	/**
	 * Gets/sets schema paths.
	 *
	 * Sets a path (if arity 2)
	 * Gets a path (if arity 1)
	 *
	 * ####Example
	 *
	 *     schema.path('name') // returns a SchemaType
	 *     schema.path('name', Number) // changes the schemaType of `name` to Number
	 *
	 * @param {String} path
	 * @param {Object} constructor
	 * @api public
	 */
	@:overload(function (path:String) : SchemaType {})
	public function path(path:String, obj:{}) : Schema;


	/**
	 * Iterates the schemas paths similar to Array#forEach.
	 *
	 * The callback is passed the pathname and schemaType as arguments on each iteration.
	 *
	 * @param {Function} fn callback function
	 * @return {Schema} this
	 * @api public
	 */
	public function eachPath(fn:String->SchemaType->Void) : Schema;

	/**
	 * Returns an Array of path strings that are required by this schema.
	 *
	 * @api public
	 * @param {Boolean} invalidate refresh the cache
	 * @return {Array}
	 */
	public function requiredPaths(invalidate:Bool) : Array<String>;

} // End of Schema class
