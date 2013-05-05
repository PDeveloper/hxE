package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
@:generic class ComponentType<T:Component> implements IComponentType
{
	
	public var id:UInt;
	
	public var componentClass:Class<Component>;
	public var bits:BitSet;
	
	public function new( id:UInt) 
	{
		this.componentClass = T;
		
		this.id = id;
		
		this.bits = new BitSet();
		this.bits.set( id + 1, 1);
	}
	
}