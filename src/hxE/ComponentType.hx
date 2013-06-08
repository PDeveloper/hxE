package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentType
{
	
	public var id:Int;
	
	public var componentClass:Class<Component>;
	public var bits:BitSet;
	
	public function new( componentClass:Class<Component>, id:Int) 
	{
		this.componentClass = componentClass;
		
		this.id = id;
		
		this.bits = new BitSet();
		this.bits.set( id + 1, 1);
	}
	
}