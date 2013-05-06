package hxE.systems;
import hxE.Demand;
import hxE.EntitySystem;

/**
 * Will process entities in time intervals!
 * @author P Svilans
 */
class IntervalSystem extends EntitySystem
{
	
	private var accumulatedTime:Float;
	private var interval:Float;

	public function new( demand:Demand, interval:Float) 
	{
		super( demand);
		
		this.interval = interval;
		this.accumulatedTime = 0.0;
	}
	
	override public function checkProcessing():Bool 
	{
		accumulatedTime += world.getDelta();
		
		if ( accumulatedTime > interval)
		{
			accumulatedTime -= interval;
			return true;
		}
		
		return false;
	}
	
}