package hxE;

/**
 * Utility to quickly access components of an entity!
 * @author P Svilans
 */
@:generic class ComponentTypeSlot<T:Component> implements IComponentTypeSlot
{
	
	private var manager:ComponentManager;
	private var type:ComponentType;
	private var componentClass:Class<Component>;
	
	/**
	 * Must do: new ComponentTypeSlot<MyComponentClass>(MyComponentClass);
	 * Verbose, yes, looking for alternatives! :)
	 * @param	componentClass the component class
	 */
	
	public function new( componentClass:Class<Component>) 
	{
		this.componentClass = componentClass;
	}
	
	/**
	 * Gets this type of component for the given entity
	 * @param	e the entity
	 * @return the component
	 */
	
	public function get( e:Entity):T
	{
		return cast manager.getComponentByType( e, type);
	}
	
	/**
	 * Check if the given entity has this type of component
	 * @param	e the entity
	 * @return true if the entity has this type of component
	 */
	
	public function has( e:Entity):Bool
	{
		return manager.hasComponentType( e, type);
	}
	
	/**
	 * Removes this type of component from the given entity
	 * @param	e the entity
	 */
	
	public function remove( e:Entity):Void
	{
		manager.removeComponentByType( e, type);
	}
	
	/**
	 * Sets the world and updates the type. SHOULDN'T BE USED manually.
	 * @param	world the world to change to
	 */
	
	public function setWorld( world:EntityWorld):Void
	{
		manager = world.componentManager;
		type = manager.getType( componentClass);
	}
	
}