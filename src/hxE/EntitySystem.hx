package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class EntitySystem implements IEntitySystem
{
	
	private var _world:EntityWorld;
	
	private var _require:BitSet;
	private var _reject:BitSet;
	private var demand:Demand;
	
	private var entities:Map<Int,Entity>;
	
	private var isPassive:Bool;
	
	public var slots:Array<IComponentTypeSlot>;
	
	public function new( demand:Demand) 
	{
		this.demand = demand;
		_require = new BitSet();
		_reject = new BitSet();
		
		isPassive = false;
		
		entities = new Map<Int,Entity>();
		slots = new Array<IComponentTypeSlot>();
	}
	
	public function registerSlot( slot:IComponentTypeSlot):Void
	{
		slots.push( slot);
	}
	
	@final
	public function _init():Void
	{
		for ( slot in slots) slot.setWorld( _world);
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
		if ( e.bits.contains( _require) && _reject.contains( e.bits))
		{
			if ( !entities.exists( e.id)) addEntity( e);
		}
		else if ( entities.exists( e.id))
		{
			entities.remove( e.id);
			onEntityRemoved( e);
		}
	}
	
	public function clear():Void
	{
		var iterator = entities.iterator();
		for ( e in iterator)
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
	
	public function destroy():Void
	{
		
	}
	
	private function get_world():EntityWorld 
	{
		return _world;
	}
	
	private function set_world(world:EntityWorld):EntityWorld 
	{
		if ( world != null)
		{
			_require.reset();
			for ( r in demand._require) _require.add( world.componentManager.getType( r).bits);
			
			_reject.reset();
			_reject.flip();
			for ( r in demand._reject) _reject.sub( world.componentManager.getType( r).bits);
		}
		
		return _world = world;
	}
	
	public var world(get_world, set_world):EntityWorld;
	
}