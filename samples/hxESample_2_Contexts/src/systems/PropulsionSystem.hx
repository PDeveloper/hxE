package systems;
import components.DirectionComponent;
import components.TransformComponent;
import hxE.Demand;
import hxE.ComponentTypeSlot;
import hxE.Entity;
import hxE.systems.EntityProcessingSystem;

/**
 * ...
 * @author P Svilans
 */
class PropulsionSystem extends EntityProcessingSystem
{
	
	private var transformSlot:ComponentTypeSlot<TransformComponent>;
	private var directionSlot:ComponentTypeSlot<DirectionComponent>;
	
	public function new() 
	{
		super( new Demand().has( TransformComponent ).has( DirectionComponent ) );
		
		transformSlot = new ComponentTypeSlot<TransformComponent>( TransformComponent );
		registerSlot( transformSlot );
		
		directionSlot = new ComponentTypeSlot<DirectionComponent>( DirectionComponent );
		registerSlot( directionSlot );
	}
	
	override private function processEntity(e:Entity):Void 
	{
		var transform = transformSlot.get( e );
		var direction = directionSlot.get( e );
		
		var dx = Math.cos( direction.angle );
		var dy = Math.sin( direction.angle );
		
		transform.x += dx * 2.0;
		transform.y += dy * 2.0;
		transform.rotation = direction.angle * 180.0 / Math.PI;
		
		direction.angle += direction.angularVelocity;
		direction.angularVelocity += Math.random() * 0.002 - 0.001;
		
		if ( direction.angularVelocity < -0.05 ) direction.angularVelocity = -0.05;
		else if ( direction.angularVelocity > 0.05 ) direction.angularVelocity = 0.05;
	}
	
}