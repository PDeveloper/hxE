package hxE;
import haxe.ds.GenericStack;

/**
 * ...
 * @author P Svilans
 */

typedef Constructable = { function new():Void; };

class EntityWorld
{
	
	private static var WORLDS:Array<EntityWorld> = new Array<EntityWorld>();
	
	public var worldId:Int;
	
	private var delta:Float;
	
	public var entityManager:EntityManager;
	public var componentManager:ComponentManager;
	
	private var systems:List<IEntitySystem>;
	private var contexts:Map<String,Dynamic>;
	
	public var tags:Map<Int,String>;

	public function new() 
	{
		_initWorldId();
		
		entityManager = new EntityManager(this);
		componentManager = new ComponentManager();
		
		systems = new List<IEntitySystem>();
		
		tags = new Map<Int,String>();
		contexts = new Map<String,Dynamic>();
		
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
	}
	
	public function updateSystems( timeStep:Float):Void
	{
		this.delta = timeStep;
		
		for ( system in systems )
		{
			if ( system.canProcess() ) system.process();
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
	
	/**
	 * Adds a system to this world
	 * @param	system
	 */
	
	public function addSystem( system:IEntitySystem):Void
	{
		systems.add( system );
		if ( system.world != null ) system.world.removeSystem( system );
		system.world = this;
		
		system.__init();
		
		// Update the system with all currently used entities!
		for ( e in entityManager.getUsedEntities() )
		{
			system.updateEntity( e );
		}
	}
	
	/**
	 * Removes a system from this world
	 * @param	system
	 */
	
	public function removeSystem( system:IEntitySystem ):Void
	{
		systems.remove( system );
		system.world = null;
	}
	
	@:generic public function getContext <T:(Constructable, Context)> ( id:String, ContextType:Class<T>):T
	{
		if ( contexts.exists(id) ) return contexts.get( id );
		else
		{
			var context = new T();
			contexts.set( id, context );
			
			context.onCreated( this );
			
			return context;
		}
	}
	
	/**
	 * Updates an entity
	 * @param	e
	 */
	
	public function updateEntity( e:Entity ):Void
	{
		for ( system in systems )
		{
			system.updateEntity( e );
		}
	}
	
	/**
	 * Destroys all entities!
	 */
	
	public function destroyEntities():Void
	{
		entityManager.destroyAll();
	}
	
	/**
	 * Destroys this world, all systems, and all entities. BAM, clean up!
	 */
	
	public function destroy():Void
	{
		WORLDS[worldId] = null;
		
		for ( system in systems )
		{
			system.destroy();
			system = null;
		}
		
		systems.clear();
		
		destroyEntities();
	}
	
	/**
	 * Destroy an entity
	 * @param	e
	 */
	
	public function destroyEntity( e:Entity ):Void
	{
		entityManager.destroy( e );
	}
	
	/**
	 * Get the current time step!
	 * @return
	 */
	
	public function getDelta():Float
	{
		return delta;
	}
	
}