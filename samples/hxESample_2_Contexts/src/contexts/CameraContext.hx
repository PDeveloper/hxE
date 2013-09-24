package contexts;
import hxE.Context;
import hxE.Entity;

/**
 * ...
 * @author P Svilans
 */
class CameraContext extends Context
{
	
	public var cameraEntities:Array<Entity>;
	
	public function new() 
	{
		super();
		
		cameraEntities = new Array<Entity>();
	}
	
}