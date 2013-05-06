package systems;
import components.TargetComponent;
import components.TransformComponent;
import hxE.ComponentTypeSlot;
import hxE.Demand;
import hxE.Entity;
import hxE.systems.EntityProcessingSystem;

/**
 * ...
 * @author P Svilans
 */
class TargetSystem extends EntityProcessingSystem
{
	
	private var transformSlot:ComponentTypeSlot<TransformComponent>;
	private var targetSlot:ComponentTypeSlot<TargetComponent>;

	public function new() 
	{
		super( new Demand().has( TransformComponent).has( TargetComponent));
		
		transformSlot = new ComponentTypeSlot<TransformComponent>(TransformComponent);
		targetSlot = new ComponentTypeSlot<TargetComponent>(TargetComponent);
		
		// REMEMBER TO REGISTER SLOTS. (I forget myself... :s)
		registerSlot( transformSlot);
		registerSlot( targetSlot);
	}
	
	override private function processEntity(e:Entity):Void 
	{
		var transform = transformSlot.get( e);
		var target = targetSlot.get( e);
		
		var dx = target.x - transform.x;
		var dy = target.y - transform.y;
		
		transform.x += dx * 0.15;
		transform.y += dy * 0.15;
	}
	
}