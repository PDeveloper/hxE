package components;
import flash.display.DisplayObject;
import hxE.Component;

/**
 * ...
 * @author P Svilans
 */
class DisplayComponent extends Component
{
	
	// Simply store a display object to show!
	public var graphic:DisplayObject;

	public function new( graphic:DisplayObject) 
	{
		super();
		
		this.graphic = graphic;
	}
	
	override public function _dispose():Void 
	{
		// If the graphic was attached to anything, then remove it!
		if ( graphic.parent != null) graphic.parent.removeChild( graphic);
	}
	
}