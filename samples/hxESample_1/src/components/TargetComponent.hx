package components;
import hxE.Component;

/**
 * ...
 * @author P Svilans
 */
class TargetComponent extends Component
{
	
	public var x:Float;
	public var y:Float;
	
	public function new( x:Float = 0.0, y:Float = 0.0) 
	{
		super();
		
		this.x = x;
		this.y = y;
	}
	
}