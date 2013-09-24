package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentType<T:Component> implements IComponentType
{
	
	public var id:Int;
	
	public var componentClass:Class<T>;
	public var bits:BitSet;
	
	public function new( componentClass:Class<T>, id:Int) 
	{
		this.componentClass = componentClass;
		
		this.id = id;
		
		this.bits = new BitSet();
		this.bits.set( id + 1, 1);
	}
	
}