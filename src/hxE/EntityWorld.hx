package hxE;
import de.polygonal.ds.SLL;

/**
 * ...
 * @author P Svilans
 */
class EntityWorld
{
	
	private var delta:Float;
	
	private var entityManager:EntityManager;
	private var componentManager:ComponentManager;
	
	private var systems:SLL<EntitySystem>;

	public function new() 
	{
		entityManager = new EntityManager(this);
		componentManager = new ComponentManager();
		
		systems = new SLL<EntitySystem>();
		
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
	
	public function create():Entity
	{
		return entityManager.create();
	}
	
	public function addSystem( system:EntitySystem):Void
	{
		systems.append( system);
		if ( system.world != null) system.world.removeSystem( system);
		system.world = this;
	}
	
	public function removeSystem( system:EntitySystem):Void
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
	
	public function destroyEntity( e:Entity):Void
	{
		entityManager.destroy( e);
	}
	
	public function getDelta():Float
	{
		return delta;
	}
	
}