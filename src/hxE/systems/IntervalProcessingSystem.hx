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
		for ( e in entitiesToProcess) processEntity( e);
	}
	
	private function processEntity( e:Entity):Void
	{
		
	}
	
}