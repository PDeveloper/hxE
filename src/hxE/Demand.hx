package hxE;
import hxE.bits.BitSet;

/**
 * Class to declare which components a system needs, and which components it rejects!
 * @author P Svilans
 */
class Demand
{
	
	public var _require:Array<Class<Component>>;
	public var _reject:Array<Class<Component>>;
	
	public function new() 
	{
		_require = new Array<Class<Component>>();
		_reject = new Array<Class<Component>>();
	}
	
	/**
	 * Add this component class to the REQUIRED types
	 * @param	componentClass
	 * @return
	 */
	
	public function has( componentClass:Class<Component>):Demand
	{
		_require.push( componentClass);
		
		return this;
	}
	
	/**
	 * Add this component class to the REJECTED types
	 * @param	componentClass
	 * @return
	 */
	
	public function lacks( componentClass:Class<Component>):Demand
	{
		_reject.push( componentClass);
		
		return this;
	}
	
}