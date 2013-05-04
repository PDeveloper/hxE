package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class DemandBits
{
	
	public var _require:BitSet;
	public var _unless:BitSet;
	
	public function new() 
	{
		_require = new BitSet();
		_unless = new BitSet();
		_unless.flip();
	}
	
	public function has( componentClass:Class<Component>):Demand
	{
		//_require.add( ComponentManager.getType( componentClass).bits);
		
		return this;
	}
	
	public function lacks( componentClass:Class<Component>):Demand
	{
		//_unless.sub( ComponentManager.getType( componentClass).bits);
		
		return this;
	}
	
}