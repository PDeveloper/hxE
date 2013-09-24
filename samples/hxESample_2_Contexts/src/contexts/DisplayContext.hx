package contexts;
import flash.display.Sprite;
import hxE.Context;

/**
 * ...
 * @author P Svilans
 */
class DisplayContext extends Context
{
	
	private var container:Sprite;
	
	public function new() 
	{
		super();
		
		container = new Sprite();
	}
	
	public function getContainer():Sprite
	{
		return container;
	}
	
}