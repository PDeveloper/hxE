package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
interface IEntitySystem
{

	public var world:EntityWorld;
	
	private var bits:BitSet;
	private var entities:IntHash<Entity>;
	
	private var isPassive:Bool;
	
	public function addEntity( e:Entity):Void;
	
	public function onEntityAdded( e:Entity):Void;
	
	public function onEntityRemoved( e:Entity):Void;
	
	public function updateEntity( e:Entity):Void;
	
	public function clear():Void;
	
	public function onBeginProcessing():Void;
	
	public function process():Void;
	
	public function processEntities( entitiesToProcess:Iterable<Entity>):Void;
	
	public function onEndProcessing():Void;
	
	public function canProcess():Bool;
	
	public function setPassive( isPassive:Bool):Void;
	
	public function getPassive():Bool;
	
	public function checkProcessing():Bool;
	
	public function destroy():Void;
	
}