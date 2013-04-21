package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class Demand
{
	
	public var bits:BitSet;

	public function new() 
	{
		bits = new BitSet();
	}
	
	public function has( componentClass:Class<Component>):Demand
	{
		bits.add( ComponentManager.getType( componentClass).bits);
		
		return this;
	}
	
	public function lacks( componentClass:Class<Component>):Demand
	{
		bits.sub( ComponentManager.getType( componentClass).bits);
		
		return this;
	}
	
}