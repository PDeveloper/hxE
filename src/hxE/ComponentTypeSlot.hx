package hxE;

/**
 * Utility to quickly access components of an entity!
 * @author P Svilans
 */
@:generic class ComponentTypeSlot<T:Component> implements IComponentTypeSlot
{
	
	private var manager:ComponentManager;
	private var type:ComponentType<T>;
	private var componentClass:Class<T>;
	private var componentContainer:ComponentContainer<T>;
	
	/**
	 * Must do: new ComponentTypeSlot<MyComponentClass>(MyComponentClass);
	 * Verbose, yes, looking for alternatives! :)
	 * @param	componentClass the component class
	 */
	
	public function new( componentClass:Class<T> ) 
	{
		this.componentClass = componentClass;
	}
	
	public function add( e:Entity, component:T ):Void
	{
		componentContainer.set( e.id, component );
		e.bits.add( type.bits );
	}
	
	/**
	 * Gets this type of component for the given entity
	 * @param	e the entity
	 * @return the component
	 */
	
	public function get( e:Entity ):T
	{
		return componentContainer.get( e.id );
	}
	
	/**
	 * Check if the given entity has this type of component
	 * @param	e the entity
	 * @return true if the entity has this type of component
	 */
	
	public function has( e:Entity ):Bool
	{
		return componentContainer.has( e.id );
	}
	
	/**
	 * Removes this type of component from the given entity
	 * @param	e the entity
	 */
	
	public function remove( e:Entity ):Void
	{
		componentContainer.remove( e.id );
		e.bits.sub( type.bits );
	}
	
	public function delete( e:Entity ):Void
	{
		componentContainer.get( e.id ).dispose();
		
		componentContainer.remove( e.id );
		e.bits.sub( type.bits );
	}
	
	/**
	 * Sets the world and updates the type. SHOULDN'T BE USED manually.
	 * @param	world the world to change to
	 */
	
	public function setWorld( world:EntityWorld ):Void
	{
		if ( world != null )
		{
			manager = world.componentManager;
			type = cast manager.getType( componentClass);
			componentContainer = cast manager.getComponentContainer( type );
		}
		else
		{
			manager = null;
			type = null;
			componentContainer = null;
		}
	}
	
}