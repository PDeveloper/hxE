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
	
	public function new( id:UInt) 
	{
		this.id = id;
		bits = new BitSet();
		isActive = true;
		
		components = new Hash<Component>();
	}
	
	public function deactivate():Void
	{
		_isActive = false;
	}
	
	public function activate():Void
	{
		_isActive = true;
	}
	
	public function update():Void
	{
		world.updateEntity( this);
	}
	
	public function addComponent( component:Component):Void
	{
		var componentClass:Class<Component> = Type.getClass( component);
		var className:String = Type.getClassName( componentClass);
		
		if ( !components.exists( className))
		{
			components.set( className, component);
			bits.add( ComponentManager.getType( componentClass).bits);
		}
		else
		{
			trace( "Component already present!");
		}
	}
	
	public function getComponentIterator():Iterator<Component>
	{
		return components.iterator();
	}
	
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
	
	public function removeComponent( component:Component):Void
	{
		var componentClass:Class<Component> = Type.getClass( component);
		removeComponentByClass( componentClass);
	}
	
	public function removeComponentByClass( componentClass:Class<Component>):Void
	{
		var className:String = Type.getClassName( componentClass);
		
		if ( components.exists( className))
		{
			components.remove( className);
			bits.sub( ComponentManager.getType( componentClass).bits);
		}
		else
		{
			trace( "No such component!");
		}
	}
	
	private function get_isActive():Bool 
	{
		return _isActive;
	}
	
	public var isActive(get_isActive, null):Bool;
	
}