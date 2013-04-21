package hxE.systems;
import hxE.Demand;
import hxE.Entity;
import hxE.EntitySystem;

/**
 * ...
 * @author P Svilans
 */
class VoidEntitySystem extends EntitySystem
{

	public function new() 
	{
		super( new Demand());
	}
	
	@final
	override public function processEntities( entitiesToProcess:Iterable<Entity):Void 
	{
		processSystem();
	}
   
	private function processSystem():Void;
	
	@final
	override public function checkProcessing():Bool 
	{
		return true;
	}
	
}