package hxE;

/**
 * Manages events
 * @author P Svilans
 */
class EntityEventManager
{
	
	private var flags:Map<String,Bool>;
	
	private var events:Map<String,Array<Dynamic>>;
	
	public function new() 
	{
		flags = new Map<String,Bool>();
		events = new Map<String,Array<Dynamic>>();
	}
	
	/**
	 * Set a flag.
	 * @param	flag
	 * @param	state
	 */
	
	public function setFlag( flag:String, state:Bool):Void
	{
		flags.set( flag, state);
	}
	
	/**
	 * Retrieve a flag - returns null if the flag hasn't been set!
	 * @param	flag
	 * @return
	 */
	
	public function getFlag( flag:String):Null<Bool>
	{
		return flags.get( flag);
	}
	
	/**
	 * Push a new event!
	 * @param	event the event id
	 * @param	value the event's data - will optimize this with a specific event class later on.
	 */
	
	public function push( event:String, value:Dynamic):Void
	{
		var buffer = events.get( event);
		if ( buffer == null)
		{
			buffer = new Array<Dynamic>();
			events.set( event, buffer);
		}
		
		buffer.push( value);
	}
	
	/**
	 * Check if this event has been registered!
	 * @param	event
	 * @return
	 */
	
	public function has( event:String):Bool
	{
		return events.exists( event);
	}
	
	/**
	 * Get all events of a certain type.
	 * @param	event the id
	 * @param	erase should erase the events?
	 * @return the event values
	 */
	
	public function getAll( event:String, erase:Bool = false):Array<Dynamic>
	{
		var buffer = events.get( event);
		if ( buffer == null) return null;
		
		var copy = buffer.copy();
		
		if ( erase) while ( buffer.length > 0) buffer.pop();
		
		return copy;
	}
	
	/**
	 * Get the next event of this type
	 * @param	event the event id
	 * @param	erase should erase event?
	 * @return the event's value
	 */
	
	public function get( event:String, erase:Bool = false):Dynamic
	{
		var buffer = events.get( event);
		if ( buffer == null || buffer.length == 0) return null;
		
		if ( erase) return buffer.shift();
		else return buffer[0];
	}
	
	/**
	 * Clear all events. This is done automagically after the entity world has finished processing all systems.
	 */
	
	public function clear():Void
	{
		for ( buffer in events) while ( buffer.length > 0) buffer.pop();
		
		for ( key in flags.keys()) flags.remove( key);
		for ( key in events.keys()) events.remove( key);
	}
	
}