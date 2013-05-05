package hxE;

/**
 * ...
 * @author P Svilans
 */
interface IComponentTypeSlot
{
	
	private var manager:ComponentManager;
	//private var type:ComponentType;
	private var componentClass:Class<Component>;
	
	public function setWorld( world:EntityWorld):Void;
	
}