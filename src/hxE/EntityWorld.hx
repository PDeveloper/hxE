package hxE;
import de.polygonal.ds.SLL;

/**
 * ...
 * @author P Svilans
 */
class EntityWorld
{
	
	private static var WORLDS:Array<EntityWorld> = new Array<EntityWorld>();
	
	public var worldId:Int;
	
	private var delta:Float;
	
	public var entityManager:EntityManager;
	public var componentManager:ComponentManager;
	
	private var systems:SLL<IEntitySystem>;
	
	private var eventManager:EntityEventManager;
	
	public var tags:Map<Int,String>;

	public function new() 
	{
		_initWorldId();
		
		entityManager = new EntityManager(this);
		componentManager = new ComponentManager();
		
		systems = new SLL<IEntitySystem>();
		
		eventManager = new EntityEventManager();
		
		tags = new Map<Int,String>();
		
		delta = 0.0;
	}
	
	private function _initWorldId():Void
	{
		if ( WORLDS.length == 0)
		{
			worldId = 0;
			WORLDS.push( this);
		}
		else
		{
			for ( i in 0...WORLDS.length)
			{
				if ( WORLDS[i] == null)
				{
					worldId = i;
					WORLDS[i] = this;
				}
			}
		}
		
		trace ( WORLDS);
	}
	
	public function getEventManager():EntityEventManager
	{
		return eventManager;
	}
	
	public function updateSystems( timeStep:Float):Void
	{
		this.delta = timeStep;
		
		for ( system in systems)
		{
			if ( system.canProcess()) system.process();
		}
		
		eventManager.clear();
	}
	
	/**
	 * Create a new entity!
	 * @return
	 */
	
	public function create():Entity
	{
		return entityManager.create();
	}
	
	public function addSystem( system:IEntitySystem):Void
	{
		systems.append( system);
		if ( system.world != null) system.world.removeSystem( system);
		system.world = this;
		
		system._init();
		
		// Update the system with all currently used entities!
		for ( e in entityManager.getUsedEntities())
		{
			system.updateEntity( e);
		}
	}
	
	public function removeSystem( system:IEntitySystem):Void
	{
		systems.remove( system);
		system.world = null;
	}
	
	public function updateEntity( e:Entity):Void
	{
		for ( system in systems)
		{
			system.updateEntity( e);
		}
	}
	
	public function destroyEntities():Void
	{
		entityManager.destroyAll();
	}
	
	public function destroy():Void
	{
		WORLDS[worldId] = null;
		
		for ( system in systems)
		{
			system.destroy();
			system = null;
		}
		
		systems.clear();
		
		destroyEntities();
	}
	
	public function destroyEntity( e:Entity):Void
	{
		entityManager.destroy( e);
	}
	
	public function getDelta():Float
	{
		return delta;
	}
	
}