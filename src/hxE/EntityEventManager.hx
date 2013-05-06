package hxE;
import de.polygonal.ds.LinkedQueue;

/**
 * Manages events
 * @author P Svilans
 */
class EntityEventManager
{
	
	private var flags:Map<String,Bool>;
	
	private var events:Map<String,LinkedQueue<Dynamic>>;
	
	public function new() 
	{
		flags = new Map<String,Bool>();
		events = new Map<String,LinkedQueue<Dynamic>>();
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
			buffer = new LinkedQueue<Dynamic>();
			events.set( event, buffer);
		}
		
		buffer.enqueue( value);
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
		
		var copy = buffer.toArray();
		
		if ( erase) buffer.clear();
		
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
		if ( buffer == null || buffer.isEmpty()) return null;
		
		if ( erase) return buffer.dequeue();
		else return buffer.peek();
	}
	
	/**
	 * Clear all events. This is done automagically after the entity world has finished processing all systems.
	 */
	
	public function clear():Void
	{
		for ( buffer in events) buffer.clear();
		
		for ( key in flags.keys()) flags.remove( key);
		for ( key in events.keys()) events.remove( key);
	}
	
}