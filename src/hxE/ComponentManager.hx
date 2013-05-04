package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentManager
{
	private var numTypes:Int;
	private var componentTypes:Hash<ComponentType>;
	
	public function new() 
	{
		numTypes = 0;
		componentTypes = new Hash<ComponentType>();
	}
	
	public function getType( componentClass:Class<Component>):ComponentType
	{
		var type:ComponentType;
		var className = Type.getClassName( componentClass);
		if ( componentTypes.exists( className))
		{
			type =  componentTypes.get( className);
		}
		else
		{
			var bits = new BitSet();
			
			numTypes++;
			bits.set( numTypes, 1);
			
			type = new ComponentType( componentClass, bits);
			componentTypes.set( className, type);
		}
		
		return type;
	}
	
}