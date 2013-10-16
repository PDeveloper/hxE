package hxE;
import haxe.ds.GenericStack;

using Lambda;

/**
 * ...
 * @author P Svilans
 */
class EntityManager
{
	
	/**
	 * Pool entities.
	 */
	
	private var freeEnt:GenericStack<Entity>;
	private var usedEnt:GenericStack<Entity>;
	
	private var nextId:Int;
	
	private var world:EntityWorld;
	
	public function new( world:EntityWorld) 
	{
		freeEnt = new GenericStack<Entity>();
		usedEnt = new GenericStack<Entity>();
		
		nextId = 0;
		
		this.world = world;
	}
	
	private function getNextId():Int
	{
		var nid = nextId;
		nextId++;
		return nid;
	}
	
	public function destroyAll():Void
	{
		for ( e in usedEnt )
		{
			destroy( e );
		}
	}
	
	public function create():Entity
	{
		var e:Entity;
		if ( freeEnt.isEmpty())
		{
			e = new Entity( getNextId(), world);
		}
		else
		{
			e = freeEnt.pop();
		}
		
		e.activate();
		
		usedEnt.add( e);
		
		return e;
	}
	
	public function getUsedEntities():List<Entity>
	{
		return usedEnt.list();
	}
	
	public function destroy( e:Entity ):Void
	{
		var components = e.getComponentIterator();
		
		for ( component in components)
		{
			e.removeComponent( component);
		}
		
		e.update();
		e.deactivate();
		
		usedEnt.remove( e);
		freeEnt.add( e);
	}
	
}