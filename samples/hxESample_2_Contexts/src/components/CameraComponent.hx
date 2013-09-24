package components;
import hxE.Component;

/**
 * ...
 * @author P Svilans
 */
class CameraComponent extends Component
{
	
	public var isRequestingFocus:Bool;
	
	public function new() 
	{
		super();
		
		isRequestingFocus = false;
	}
	
	public function requestFocus():Void
	{
		isRequestingFocus = true;
	}
	
}