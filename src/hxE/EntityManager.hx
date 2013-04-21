package hxE;
import de.polygonal.ds.LinkedStack;
import de.polygonal.ds.Stack;

/**
 * ...
 * @author P Svilans
 */
class EntityManager
{
	
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
	
	public function create():Entity
	{
		var e:Entity;
		if ( freeEnt.isEmpty())
		{
			e = new Entity( getNextId());
		}
		else
		{
			e = freeEnt.pop();
		}
		
		e.world = world;
		e.activate();
		
		usedEnt.push( e);
		
		return e;
	}
	
	public function destroy( e:Entity):Void
	{
		var components = e.getComponentIterator();
		
		for ( component in components)
		{
			e.removeComponent( component);
		}
		
		usedEnt.remove( e);
		freeEnt.push( e);
	}
	
}