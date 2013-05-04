package hxE;
import de.polygonal.ds.LinkedStack;
import de.polygonal.ds.Stack;

/**
 * ...
 * @author P Svilans
 */
class EntityManager
{
	
	/**
	 * Pool entities.
	 */
	
	private var freeEnt:Stack<Entity>;
	private var usedEnt:Stack<Entity>;
	
	private var nextId:UInt;
	
	private var world:EntityWorld;
	
	public function new( world:EntityWorld) 
	{
		freeEnt = new LinkedStack<Entity>();
		usedEnt = new LinkedStack<Entity>();
		
		nextId = 0;
		
		this.world = world;
	}
	
	private function getNextId():UInt
	{
		var nid = nextId;
		nextId++;
		return nid;
	}
	
	public function destroyAll():Void
	{
		for ( e in usedEnt)
		{
			destroy( e);
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
		
		usedEnt.push( e);
		
		return e;
	}
	
	public function getUsedEntities():Array<Entity>
	{
		return usedEnt.toArray();
	}
	
	public function destroy( e:Entity):Void
	{
		var components = e.getComponentIterator();
		
		for ( component in components)
		{
			e.removeComponent( component);
		}
		
		e.update();
		e.deactivate();
		
		usedEnt.remove( e);
		freeEnt.push( e);
	}
	
}