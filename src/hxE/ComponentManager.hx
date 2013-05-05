package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentManager
{
	private var numTypes:Int;
	private var componentTypes:Map < String, IComponentType > ;
	
	private var entityComponents:Array < Map < Int, Component >> ;
	
	public function new() 
	{
		numTypes = 0;
		componentTypes = new Map < String, IComponentType > ();
		
		entityComponents = new Array < Map < Int, Component >> ();
	}
	
	public function register( e:Entity):Map<Int,Component>
	{
		entityComponents[ e.id] = new Map<Int,Component>();
		return entityComponents[ e.id];
	}
	
	@:generic public function addComponent<T:Component>( e:Entity, c:T):Void
	{
		addComponentType( e, c, getType());
	}
	
	@:generic public function addComponentType<T:Component>( e:Entity, c:T, t:ComponentType<T>):Void
	{
		entityComponents[ e.id].set( t.id, c);
		e.bits.add( t.bits);
	}
	
	@:generic public function hasComponent<T:Component>( e:Entity):Bool
	{
		var t = getType();
		return hasComponentType( e, t);
	}
	
	@:generic public function hasComponentType<T:Component>( e:Entity, t:ComponentType<T>):Bool
	{
		var components = entityComponents[ e.id];
		
		if ( components.exists( t.id)) return true;
		
		return false;
	}
	
	@:generic public function getComponent<T:Component>( e:Entity):T
	{
		var t = getType();
		return getComponentByType( e, t);
	}
	
	@:generic public function getComponentByType<T:Component>( e:Entity, t:ComponentType<T>):T
	{
		var components = entityComponents[ e.id];
		return components.get( t.id);
	}
	
	@:generic public function removeComponent<T:Component>( e:Entity, c:T = null):Void
	{
		var t = getType();
		removeComponentByType( e, t);
	}
	
	@:generic public function removeComponentByType<T:Component>( e:Entity, t:ComponentType<T>):Void
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
	
	@:generic public function getType<T:Component>( c:Class<T>):ComponentType<T>
	{
		var type:ComponentType<T>;
		
		if ( componentTypes.exists( c))
		{
			type =  componentTypes.get( c);
		}
		else
		{
			type = new ComponentType(numTypes);
			numTypes++;
			componentTypes.set( c, type);
		}
		
		return type;
	}
	
}