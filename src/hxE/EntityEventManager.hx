package hxE;
import de.polygonal.ds.LinkedQueue;

/**
 * ...
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
	
	public function setFlag( flag:String, state:Bool):Void
	{
		flags.set( flag, state);
	}
	
	public function getFlag( flag:String):Null<Bool>
	{
		return flags.get( flag);
	}
	
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
	
	public function has( event:String):Bool
	{
		return events.exists( event);
	}
	
	public function getAll( event:String, erase:Bool = false):Array<Dynamic>
	{
		var buffer = events.get( event);
		if ( buffer == null) return null;
		
		var copy = buffer.toArray();
		
		if ( erase) buffer.clear();
		
		return copy;
	}
	
	public function get( event:String, erase:Bool = false):Dynamic
	{
		var buffer = events.get( event);
		if ( buffer == null || buffer.isEmpty()) return null;
		
		if ( erase) return buffer.dequeue();
		else return buffer.peek();
	}
	
	public function clear():Void
	{
		for ( buffer in events) buffer.clear();
		
		for ( key in flags.keys()) flags.remove( key);
		for ( key in events.keys()) events.remove( key);
	}
	
}