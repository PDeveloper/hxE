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
	private var componentTypes:Map<String , IComponentType>;
	
	private var entityComponents:Array<ComponentContainerBase>;
	
	public function new() 
	{
		numTypes = 0;
		componentTypes = new Map<String,IComponentType>();
		entityComponents = new Array<ComponentContainerBase>();
	}
	
	public function getComponentContainer( t:IComponentType ):ComponentContainerBase
	{
		return entityComponents[ t.id ];
	}
	
	public function getOwnerId( c:Component ):Int
	{
		var type = getType( Type.getClass( c ) );
		var container = entityComponents[ type.id ];
		var array = container.getArray();
		for ( i in 0...array.length )
		{
			if ( array[ i ] == c ) return i;
		}
		
		return -1;
	}
	
	/**
	 * Add a component to the given entity.
	 * @param	e the entity
	 * @param	c the component
	 */
	
	public function addComponent( e:Entity, c:Component ):Void
	{
		var t = getType( Type.getClass( c ) );
		
		addComponentType( e, c, t );
	}
	
	/**
	 * Add a component by type. Unsafe! (But faster)
	 * @param	e the entity
	 * @param	c the component
	 * @param	t the component type
	 */
	
	public function addComponentType( e:Entity, c:Component, t:IComponentType ):Void
	{
		entityComponents[ t.id ].setComponent( e.id, c );
		e.bits.add( t.bits );
	}
	
	/**
	 * Checks to see if an entity has a component by Class<Component>
	 * @param	e the entity
	 * @param	c the component class
	 * @return true if the entity has the component already
	 */
	
	public function hasComponentClass( e:Entity, c:Class<Component> ):Bool
	{
		var t = getType( c );
		return hasComponentType( e, t );
	}
	
	/**
	 * Checks to see if an entity has a component by component type
	 * @param	e the entity
	 * @param	t the component type
	 * @return true if the entity has the component already
	 */
	
	public function hasComponentType( e:Entity, t:IComponentType ):Bool
	{
		var components = entityComponents[ t.id ];
		
		return components.has( e.id );
	}
	
	/**
	 * Get a component from the entity by Class<Component>
	 * @param	e the entity
	 * @param	componentClass the component class
	 * @return the component
	 */
	
	public function getComponentByClass( e:Entity, componentClass:Class<Component> ):Component
	{
		var t = getType( componentClass );
		
		return getComponentByType( e, t );
	}
	
	/**
	 * Get a component from the entity by component type
	 * @param	e the entity
	 * @param	t the component type
	 * @return the component
	 */
	
	public function getComponentByType( e:Entity, t:IComponentType ):Component
	{
		var components = entityComponents[ t.id ];
		return components.getComponent( e.id );
	}
	
	/**
	 * Remove a component from an entity by Class<Component>
	 * @param	e the entity
	 * @param	c the component class
	 */
	
	public function removeComponentByClass( e:Entity, c:Class<Component> ):Void
	{
		var t = getType( c );
		removeComponentByType( e, t );
	}
	
	/**
	 * Remove a component from an entity by component type
	 * @param	e the entity
	 * @param	t the component type
	 */
	
	public function removeComponentByType( e:Entity, t:IComponentType ):Void
	{
		var components = entityComponents[ t.id ];
		
		components.remove( e.id );
		
		e.bits.sub( t.bits );
	}
	
	/**
	 * Remove a component from an entity by Class<Component>
	 * @param	e the entity
	 * @param	c the component class
	 */
	
	public function deleteComponentByClass( e:Entity, c:Class<Component> ):Void
	{
		var t = getType( c );
		removeComponentByType( e, t );
	}
	
	/**
	 * Remove a component from an entity by component type
	 * @param	e the entity
	 * @param	t the component type
	 */
	
	public function deleteComponentByType( e:Entity, t:IComponentType ):Void
	{
		var components = entityComponents[ t.id ];
		
		components.getComponent( e.id ).dispose();
		components.remove( e.id );
		
		e.bits.sub( t.bits );
	}
	
	/**
	 * Get all components for an entity.
	 * @param	e the entity
	 * @return an iterator of all components
	 */
	
	public function getComponents( e:Entity ):List<Component>
	{
		var l = new List<Component>();
		for ( components in entityComponents )
		{
			if ( components.has( e.id ) ) l.add( components.getComponent( e.id ) );
		}
		
		return l;
	}
	
	/**
	 * Get the component type for a given class.
	 * @param	componentClass the component class
	 * @return the component type
	 */
	
	public function getType<T:Component>( componentClass:Class<T> ):IComponentType
	{
		var type:IComponentType;
		var className = Type.getClassName( componentClass );
		if ( componentTypes.exists( className ) )
		{
			type = componentTypes.get( className );
		}
		else
		{
			type = new ComponentType( componentClass, numTypes );
			entityComponents[ numTypes ] = new ComponentContainer<T>();
			numTypes++;
			componentTypes.set( className, type );
		}
		
		return type;
	}
	
}