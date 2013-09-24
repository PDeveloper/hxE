package hxE;
import hxE.Component;

/**
 * ...
 * @author P Svilans
 */
class ComponentContainer<T:Component> extends ComponentContainerBase
{
	
	public var container:Array<T>;
	
	public function new() 
	{
		super();
		
		container = new Array<T>();
	}
	
	override public function remove( index:Int ):Void
	{
		container[ index ] = null;
	}
	
	override public function has( index:Int ):Bool 
	{
		return container[ index] != null;
	}
	
	override public function setComponent( index:Int, c:Component ):Void 
	{
		container[ index ] = cast c;
	}
	
	public function set( index:Int, c:T ):Void
	{
		container[ index ] = c;
	}
	
	override public function getComponent( index:Int ):Component 
	{
		return container[ index ];
	}
	
	public function get( index:Int ):T
	{
		return container[ index ];
	}
	
	override public function getArray():Array<Dynamic> 
	{
		return container;
	}
	
}