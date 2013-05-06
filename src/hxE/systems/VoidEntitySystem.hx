package hxE.systems;
import hxE.Demand;
import hxE.Entity;
import hxE.EntitySystem;

/**
 * Will always process
 * @author P Svilans
 */
class VoidEntitySystem extends EntitySystem
{

	public function new() 
	{
		super( new Demand());
	}
	
	@final
	override public function processEntities( entitiesToProcess:Iterable<Entity>):Void 
	{
		processSystem();
	}
	
	/**
	 * Override this to process this system!
	 */
	
	private function processSystem():Void
	{
		
	}
	
	override public function checkProcessing():Bool 
	{
		return true;
	}
	
}