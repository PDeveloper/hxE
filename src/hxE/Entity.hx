package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class Entity
{
	
	public var id:UInt;
	public var bits:BitSet;
	
	private var _isActive:Bool;
	
	public var world:EntityWorld;
	
	private var components:Hash<Component>;
	
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
		
		components = new Hash<Component>();
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
		var componentClass:Class<Component> = Type.getClass( component);
		var className:String = Type.getClassName( componentClass);
		
		if ( !components.exists( className))
		{
			components.set( className, component);
			bits.add( world.componentManager.getType( componentClass).bits);
		}
		else
		{
			trace( "Component already present!");
		}
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	public function hasComponent( componentClass:Class<Component>):Bool
	{
		var className:String = Type.getClassName( componentClass);
		
		return components.exists( className);
	}
	
	public function hasComponentType( component:Component):Bool
	{
		var componentClass:Class<Component> = Type.getClass( component);
		return hasComponent( componentClass);
	}
	
	/**
	 * Get an iterator of all components owned by this entity.
	 * @return
	 */
	
	public function getComponentIterator():Iterator<Component>
	{
		return components.iterator();
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	public function getComponent( componentClass:Class<Component>):Component
	{
		var className:String = Type.getClassName( componentClass);
		
		if ( components.exists( className))
		{
			return components.get( className);
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * Remove component from this entity.
	 * @param	component
	 */
	
	public function removeComponent( component:Component, dispose:Bool = true):Void
	{
		var componentClass:Class<Component> = Type.getClass( component);
		removeComponentByClass( componentClass, dispose);
	}
	
	/**
	 * Removes the component by type of component rather than reference.
	 * @param	componentClass
	 */
	
	public function removeComponentByClass( componentClass:Class<Component>, dispose:Bool = true):Void
	{
		var className:String = Type.getClassName( componentClass);
		
		if ( components.exists( className))
		{
			if ( dispose) components.get( className)._dispose();
			components.remove( className);
			bits.sub( world.componentManager.getType( componentClass).bits);
		}
		else
		{
			trace( "No such component!");
		}
	}
	
	public function destroy():Void
	{
		world.destroyEntity( this);
	}
	
	private function get_isActive():Bool 
	{
		return _isActive;
	}
	
	public var isActive(get_isActive, null):Bool;
	
}