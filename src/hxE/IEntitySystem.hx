package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
interface IEntitySystem
{
	
	private var demand:Demand;
	
	private var entities:List<Entity>;
	
	private var isPassive:Bool;
	
	public function registerSlot( slot:IComponentTypeSlot):Void;
	
	public function __init():Void;
	public function initialize():Void;
	
	public function __dispose():Void;
	public function dispose():Void;
	
	public function addEntity( e:Entity ):Void;
	
	public function onEntityAdded( e:Entity ):Void;
	
	public function onEntityRemoved( e:Entity ):Void;
	
	public function updateEntity( e:Entity ):Void;
	
	public function clear():Void;
	
	public function onBeginProcessing():Void;
	
	public function process():Void;
	
	public function processEntities( entitiesToProcess:Iterable<Entity> ):Void;
	
	public function onEndProcessing():Void;
	
	public function canProcess():Bool;
	
	public function setPassive( isPassive:Bool ):Void;
	
	public function getPassive():Bool;
	
	public function checkProcessing():Bool;
	
	public function destroy():Void;
	
	private function get_world():EntityWorld;
	private function set_world(world:EntityWorld):EntityWorld;
	public var world(get_world, set_world):EntityWorld;
	
}