package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentType
{
	
	public var id:UInt;
	
	public var componentClass:Class<Component>;
	public var bits:BitSet;
	
	public function new( componentClass:Class<Component>, id:UInt) 
	{
		this.componentClass = componentClass;
		
		this.id = id;
		
		this.bits = new BitSet();
		this.bits.set( id + 1, 1);
	}
	
}