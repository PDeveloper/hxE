package hxE;
import hxE.bits.BitSet;

/**
 * ComponentManager of an EntityWorld. Stores and manages all components relating to all entities,
 * also holds the ComponentTypes.
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
	
	/**
	 * Register an entity to the manager; sets up component storage for this entity.
	 * @param	e the entity
	 * @return
	 */
	
	public function register( e:Entity):Map<Int,Component>
	{
		entityComponents[ e.id] = new Map<Int,Component>();
		return entityComponents[ e.id];
	}
	
	/**
	 * Add a component to the given entity.
	 * @param	e the entity
	 * @param	c the component
	 */
	
	public function addComponent( e:Entity, c:Component):Void
	{
		var t = getType( Type.getClass( c));
		
		addComponentType( e, c, t);
	}
	
	/**
	 * Add a component by type. Unsafe! (But faster)
	 * @param	e the entity
	 * @param	c the component
	 * @param	t the component type
	 */
	
	public function addComponentType( e:Entity, c:Component, t:ComponentType):Void
	{
		entityComponents[ e.id].set( t.id, c);
		e.bits.add( t.bits);
	}
	
	/**
	 * Checks to see if an entity has a component by Class<Component>
	 * @param	e the entity
	 * @param	c the component class
	 * @return true if the entity has the component already
	 */
	
	public function hasComponentClass( e:Entity, c:Class<Component>):Bool
	{
		var t = getType( c);
		return hasComponentType( e, t);
	}
	
	/**
	 * Checks to see if an entity has a component by component type
	 * @param	e the entity
	 * @param	t the component type
	 * @return true if the entity has the component already
	 */
	
	public function hasComponentType( e:Entity, t:ComponentType):Bool
	{
		var components = entityComponents[ e.id];
		
		if ( components.exists( t.id)) return true;
		
		return false;
	}
	
	/**
	 * Get a component from the entity by Class<Component>
	 * @param	e the entity
	 * @param	componentClass the component class
	 * @return the component
	 */
	
	public function getComponentByClass( e:Entity, componentClass:Class<Component>):Component
	{
		var t = getType( componentClass);
		
		return getComponentByType( e, t);
	}
	
	/**
	 * Get a component from the entity by component type
	 * @param	e the entity
	 * @param	t the component type
	 * @return the component
	 */
	
	public function getComponentByType( e:Entity, t:ComponentType):Component
	{
		var components = entityComponents[ e.id];
		return components.get( t.id);
	}
	
	/**
	 * Remove a component from an entity by Class<Component>
	 * @param	e the entity
	 * @param	c the component class
	 */
	
	public function removeComponentByClass( e:Entity, c:Class<Component>):Void
	{
		var t = getType( c);
		removeComponentByType( e, t);
	}
	
	/**
	 * Remove a component from an entity by component type
	 * @param	e the entity
	 * @param	t the component type
	 */
	
	public function removeComponentByType( e:Entity, t:ComponentType):Void
	{
		var components = entityComponents[ e.id];
		
		components.get( t.id)._dispose();
		components.remove( t.id);
		
		e.bits.sub( t.bits);
	}
	
	/**
	 * Get all components for an entity.
	 * @param	e the entity
	 * @return an iterator of all components
	 */
	
	public function getComponents( e:Entity):Iterator<Component>
	{
		return entityComponents[ e.id].iterator();
	}
	
	/**
	 * Get the component type for a given class.
	 * @param	componentClass the component class
	 * @return the component type
	 */
	
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