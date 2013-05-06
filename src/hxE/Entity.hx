package hxE;
import hxE.bits.BitSet;

/**
 * An ENTITY! :o
 * @author P Svilans
 */
class Entity
{
	
	public var id:UInt;
	public var bits:BitSet;
	
	private var _isActive:Bool;
	
	public var world:EntityWorld;
	
	private var components:Map<Int,Component>;
	
	/**
	 * Entity constructor. Should be treated as private, and never manually invoked.
	 * Use myEntityWorld.create();
	 * @param	id A unique id for this Entity.
	 */
	
	public function new( id:UInt, world:EntityWorld) 
	{
		this.id = id;
		this.world = world;
		
		bits = new BitSet();
		isActive = true;
		
		components = world.componentManager.register( this);
	}
	
	/**
	 * Deactivate this entity so that it does not get processed by systems.
	 */
	
	public function deactivate():Void
	{
		_isActive = false;
	}
	
	/**
	 * Activate this entity so that it is processed by systems.
	 */
	
	public function activate():Void
	{
		_isActive = true;
	}
	
	/**
	 * Call this everytime you change this entity's components!
	 */
	
	public function update():Void
	{
		world.updateEntity( this);
	}
	
	/**
	 * Add a component if it doesn't exist already.
	 * @param	component The component to add.
	 */
	
	public function addComponent( component:Component):Void
	{
		world.componentManager.addComponent( this, component);
	}
	
	/**
	 * Check if this entity has the component class.
	 * @param	componentClass The component class.
	 * @return true if it has this component class
	 */
	
	public function hasComponent( componentClass:Class<Component>):Bool
	{
		return world.componentManager.hasComponentClass( this, componentClass);
	}
	
	/**
	 * Check if this entity has the component type.
	 * @param	type The component type.
	 * @return true if it has this component type
	 */
	
	public function hasComponentType( type:ComponentType):Bool
	{
		return world.componentManager.hasComponentType( this, type);
	}
	
	/**
	 * Get an iterator of all components owned by this entity.
	 * @return
	 */
	
	public function getComponentIterator():Iterator<Component>
	{
		return world.componentManager.getComponents( this);
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	public function getComponent( componentClass:Class<Component>):Component
	{
		return world.componentManager.getComponentByClass( this, componentClass);
	}
	
	public function getComponentByType( componentType:ComponentType):Component
	{
		return world.componentManager.getComponentByType( this, componentType);
	}
	
	/**
	 * Remove component from this entity.
	 * @param	component
	 */
	
	public function removeComponent( component:Component):Void
	{
		world.componentManager.removeComponentByClass( this, Type.getClass( component));
	}
	
	/**
	 * Removes the component by type of component rather than reference.
	 * @param	componentClass
	 */
	
	public function removeComponentByClass( componentClass:Class<Component>):Void
	{
		world.componentManager.removeComponentByClass( this, componentClass);
	}
	
	public function removeComponentByType( componentType:ComponentType):Void
	{
		world.componentManager.removeComponentByType( this, componentType);
	}
	
	/**
	 * Tag this entity with an Id.
	 * @param	tag the id.
	 */
	
	public function setTag( tag:String):Void
	{
		world.tags.set( id, tag);
	}
	
	/**
	 * Get this entity's tag.
	 * @return returns null if it has not been tagged!
	 */
	
	public function getTag():String
	{
		return world.tags.get( id);
	}
	
	/**
	 * Destroy this entity!
	 */
	
	public function destroy():Void
	{
		world.destroyEntity( this);
	}
	
	/**
	 * Check if this entity is active!
	 * @return
	 */
	
	private function get_isActive():Bool 
	{
		return _isActive;
	}
	
	public var isActive(get_isActive, null):Bool;
	
}