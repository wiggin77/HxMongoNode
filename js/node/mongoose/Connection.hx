package js.node.mongoose;

@:jsRequire("mongoose")
extern class Connection extends EventEmitter<Connection>
{
	/**
	 * Connection constructor
	 *
	 * For practical reasons, a Connection equals a Db.
	 *
	 * @param {Mongoose} base a mongoose instance
	 * @inherits NodeJS EventEmitter http://nodejs.org/api/events.html#events_class_events_eventemitter
	 * @event `connecting`: Emitted when `connection.{open,openSet}()` is executed on this connection.
	 * @event `connected`: Emitted when this connection successfully connects to the db. May be emitted _multiple_ times in `reconnected` scenarios.
	 * @event `open`: Emitted after we `connected` and `onOpen` is executed on all of this connections models.
	 * @event `disconnecting`: Emitted when `connection.close()` was executed.
	 * @event `disconnected`: Emitted after getting disconnected from the db.
	 * @event `close`: Emitted after we `disconnected` and `onClose` executed on all of this connections models.
	 * @event `reconnected`: Emitted after we `connected` and subsequently `disconnected`, followed by successfully another successfull connection.
	 * @event `error`: Emitted when an error occurs on this connection.
	 * @event `fullsetup`: Emitted in a replica-set scenario, when all nodes specified in the connection string are connected.
	 * @api public
	 */
	public function new(base:Mongoose);

	
}