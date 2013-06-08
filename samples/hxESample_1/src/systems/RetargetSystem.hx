package systems;
import components.TargetComponent;
import flash.geom.Rectangle;
import hxE.ComponentTypeSlot;
import hxE.Demand;
import hxE.Entity;
import hxE.systems.IntervalProcessingSystem;

/**
 * ...
 * @author P Svilans
 */
class RetargetSystem extends IntervalProcessingSystem
{
	
	private var bounds:Rectangle;
	
	private var targetSlot:ComponentTypeSlot<TargetComponent>;

	public function new( bounds:Rectangle) 
	{
		super( new Demand().has( TargetComponent), 1.0);
		
		this.bounds = bounds;
		
		targetSlot = new ComponentTypeSlot<TargetComponent>(TargetComponent);
		registerSlot( targetSlot);
	}
	
	override private function processEntity(e:Entity):Void 
	{
		var target = targetSlot.get( e);
		
		var dx:Float = bounds.left + Math.random() * bounds.width;
		var dy:Float = bounds.top + Math.random() * bounds.height;
		
		target.x = dx;
		target.y = dy;
	}
	
}