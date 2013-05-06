package hxE.systems;

/**
 * Will always process, over intervals in time.
 * @author P Svilans
 */
class VoidIntervalSystem extends VoidEntitySystem
{
	
	private var accumulatedTime:Float;
	private var interval:Float;

	public function new( interval:Float) 
	{
		super();
		
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