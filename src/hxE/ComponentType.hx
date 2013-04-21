package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentType
{
	
	public var componentClass:Class<Component>;
	public var bits:BitSet;
	
	public function new( componentClass:Class<Component>, bits:BitSet) 
	{
		this.componentClass = componentClass;
		this.bits = bits;
	}
	
}