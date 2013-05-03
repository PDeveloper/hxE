package hxE;
import de.polygonal.ds.SLL;

/**
 * ...
 * @author P Svilans
 */
class EntityWorld
{
	
	private var delta:Float;
	
	public var entityManager:EntityManager;
	private var componentManager:ComponentManager;
	
	private var systems:SLL<IEntitySystem>;

	public function new() 
	{
		entityManager = new EntityManager(this);
		componentManager = new ComponentManager();
		
		systems = new SLL<IEntitySystem>();
		
		delta = 0.0;
	}
	
	public function updateSystems( timeStep:Float):Void
	{
		this.delta = timeStep;
		
		for ( system in systems)
		{
			if ( system.canProcess()) system.process();
		}
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