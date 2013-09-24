package components;
import hxE.Component;

/**
 * ...
 * @author P Svilans
 */
class TransformComponent extends Component
{
	
	// Simple storage of coordinates and transforms
	public var x:Float;
	public var y:Float;
	
	public var rotation:Float;
	
	public var scaleX:Float;
	public var scaleY:Float;

	public function new( x:Float = 0.0, y:Float = 0.0, rotation:Float = 0.0, scaleX:Float = 1.0, scaleY:Float = 1.0) 
	{
		super();
		
		this.x = x;
		this.y = y;
		
		this.rotation = rotation;
		
		this.scaleX = scaleX;
		this.scaleY = scaleY;
	}
	
}