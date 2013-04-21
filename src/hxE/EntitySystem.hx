package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class EntitySystem
{
	
	public var world:EntityWorld;
	
	private var bits:BitSet;
	private var entities:IntHash<Entity>;
	
	private var isPassive:Bool;
	
	public function new( demand:Demand) 
	{
		bits = demand.bits;
		isPassive = false;
		
		entities = new IntHash<Entity>();
	}
	
	@final
	public function addEntity( e:Entity):Void
	{
		entities.set( e.id, e);
		
		onEntityAdded( e);
	}
	
	public function onEntityAdded( e:Entity):Void
	{
		
	}
	
	public function onEntityRemoved( e:Entity):Void
	{
		
	}
	
	@final
	public function updateEntity( e:Entity):Void
	{
		if ( bits.contains( e.bits))
		{
			if ( !entities.exists( e.id)) addEntity( e);
		}
		else if ( entities.exists( e.id))
		{
			entities.remove( e.id);
			onEntityRemoved( e);
		}
	}
	
	public function onBeginProcessing():Void
	{
		
	}
	
	@final
	public function process():Void
	{
		onBeginProcessing();
		processEntities( entities);
		onEndProcessing();
	}
	
	public function processEntities( entitiesToProcess:Iterable<Entity>):Void
	{
		
	}
	
	public function onEndProcessing():Void
	{
		
	}
	
	@final
	public function canProcess():Bool
	{
		return !isPassive && checkProcessing();
	}
	
	@final
	public function setPassive( isPassive:Bool):Void
	{
		this.isPassive = isPassive;
	}
	
	@final
	public function getPassive():Bool
	{
		return isPassive;
	}
	
	public function checkProcessing():Bool
	{
		return true;
	}
	
}