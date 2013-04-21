package hxE.systems;
import hxE.Demand;
import hxE.Entity;
import hxE.EntitySystem;

/**
 * ...
 * @author P Svilans
 */
class EntityProcessingSystem extends EntitySystem
{

	public function new( demand:Demand) 
	{
		super( demand);
	}
	
	@final
	override public function processEntities(entitiesToProcess:Iterable<Entity>):Void 
	{
		super.processEntities(entitiesToProcess);
	}
	
	private function processEntity( e:Entity):Void
	{
		
	}
	
}