package contexts;
import flash.geom.Rectangle;
import hxE.Context;

/**
 * ...
 * @author P Svilans
 */
class ViewContext extends Context
{
	
	public var view:Rectangle;
	
	public function new() 
	{
		super();
		
		view = new Rectangle();
	}
	
	public function set( x:Float, y:Float, width:Float, height:Float ):Void
	{
		view.x = x;
		view.y = y;
		view.width = width;
		view.height = height;
	}
	
}