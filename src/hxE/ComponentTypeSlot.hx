package hxE;

/**
 * ...
 * @author P Svilans
 */
@:generic class ComponentTypeSlot<T:Component> implements IComponentTypeSlot
{
	
	private var manager:ComponentManager;
	private var type:ComponentType;
	private var componentClass:Class<Component>;
	
	public function new( componentClass:Class<Component>) 
	{
		this.componentClass = componentClass;
	}
	
	public function get( e:Entity):T
	{
		return cast manager.getComponentByType( e, type);
	}
	
	public function has( e:Entity):Bool
	{
		return manager.hasComponentType( e, type);
	}
	
	public function remove( e:Entity):Void
	{
		manager.removeComponentByType( e, type);
	}
	
	public function setWorld( world:EntityWorld):Void
	{
		manager = world.componentManager;
		type = manager.getType( componentClass);
	}
	
}