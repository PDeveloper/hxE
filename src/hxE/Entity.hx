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
	
	@:generic public function addComponent<T:Component>( component:T):Void
	{
		world.componentManager.addComponent( this, component);
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	@:generic public function hasComponent<T:Component>():Bool
	{
		return world.componentManager.hasComponent<T>( this);
	}
	
	@:generic public function hasComponentType<T:Component>( type:ComponentType<T>):Bool
	{
		return world.componentManager.hasComponentType( this, type);
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	@:generic public function getComponent<T:Component>():T
	{
		return world.componentManager.getComponent<T>( this);
	}
	
	@:generic public function getComponentByType<T:Component>( type:ComponentType<T>):T
	{
		return world.componentManager.getComponentByType( this, type);
	}
	
	/**
	 * Get an iterator of all components owned by this entity.
	 * @return
	 */
	
	public function getComponentIterator():Iterator<Component>
	{
		return world.componentManager.getComponents( this);
		//return components.iterator();
	}
	
	/**
	 * Remove component from this entity.
	 * @param	component
	 */
	
	@:generic public function removeComponent<T:Component>( component:T = null):Void
	{
		world.componentManager.removeComponent<T>( this);
	}
	
	/**
	 * Removes the component by type of component rather than reference.
	 * @param	componentClass
	 */
	
	public function removeComponentByClass( componentClass:Class<Component>):Void
	{
		//world.componentManager.removeComponentByClass( this, componentClass);
		/*var className:String = Type.getClassName( componentClass);
		
		if ( components.exists( className))
		{
			if ( dispose) components.get( className)._dispose();
			components.remove( className);
			bits.sub( world.componentManager.getType( componentClass).bits);
		}
		else
		{
			trace( "No such component!");
		}*/
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