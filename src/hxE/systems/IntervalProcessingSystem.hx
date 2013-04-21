package hxE.systems;
import hxE.Demand;
import hxE.Entity;

/**
 * ...
 * @author P Svilans
 */
class IntervalProcessingSystem extends IntervalSystem
{

	public function new( demand:Demand, interval:Float) 
	{
		super( demand, interval);
	}
	
	@final
	override public function processEntities(entitiesToProcess:Iterable<Entity>):Void 
	{
		super.processEntities(entitiesToProcess);
	}
	
	private function processEntity( Entity e):Void
	{
		
	}
	
}