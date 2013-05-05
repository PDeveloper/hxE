package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentManager
{
	private var numTypes:Int;
	private var componentTypes:Map<String,ComponentType>;
	
	private var entityComponents:Array<Map<Int,Component>>;
	
	public function new() 
	{
		numTypes = 0;
		componentTypes = new Map<String,ComponentType>();
		entityComponents = new Array<Map<Int,Component>>();
	}
	
	public function register( e:Entity):Map<Int,Component>
	{
		entityComponents[ e.id] = new Map<Int,Component>();
		return entityComponents[ e.id];
	}
	
	public function addComponent( e:Entity, c:Component):Void
	{
		var t = getType( Type.getClass( c));
		
		addComponentType( e, c, t);
	}
	
	public function addComponentType( e:Entity, c:Component, t:ComponentType):Void
	{
		entityComponents[ e.id].set( t.id, c);
		e.bits.add( t.bits);
	}
	
	public function hasComponentClass( e:Entity, c:Class<Component>):Bool
	{
		var t = getType( c);
		return hasComponentType( e, t);
	}
	
	public function hasComponentType( e:Entity, t:ComponentType):Bool
	{
		var components = entityComponents[ e.id];
		
		if ( components.exists( t.id)) return true;
		
		return false;
	}
	
	public function getComponentByClass( e:Entity, componentClass:Class<Component>):Component
	{
		var t = getType( componentClass);
		
		return getComponentByType( e, t);
	}
	
	public function getComponentByType( e:Entity, t:ComponentType):Component
	{
		var components = entityComponents[ e.id];
		return components.get( t.id);
	}
	
	public function removeComponentByClass( e:Entity, c:Class<Component>):Void
	{
		var t = getType( c);
		removeComponentByType( e, t);
	}
	
	public function removeComponentByType( e:Entity, t:ComponentType):Void
	{
		var components = entityComponents[ e.id];
		
		components.get( t.id)._dispose();
		components.remove( t.id);
		
		e.bits.sub( t.bits);
	}
	
	public function getComponents( e:Entity):Iterator<Component>
	{
		return entityComponents[ e.id].iterator();
	}
	
	public function getType( componentClass:Class<Component>):ComponentType
	{
		var type:ComponentType;
		var className = Type.getClassName( componentClass);
		if ( componentTypes.exists( className))
		{
			type =  componentTypes.get( className);
		}
		else
		{
			type = new ComponentType( componentClass, numTypes);
			numTypes++;
			componentTypes.set( className, type);
		}
		
		return type;
	}
	
}