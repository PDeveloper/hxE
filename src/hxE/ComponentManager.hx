package hxE;
import hxE.bits.BitSet;

/**
 * ...
 * @author P Svilans
 */
class ComponentManager
{
	
	private static var i:ComponentManager;
	
	private var numTypes:Int;
	private var componentTypes:Hash<ComponentType>;
	
	public function new() 
	{
		numTypes = 0;
		componentTypes = new Hash<ComponentType>();
		
		i = this;
	}
	
	public static function getType( componentClass:Class<Component>):ComponentType
	{
		if ( i == null) new ComponentManager();
		
		var type:ComponentType;
		var className = Type.getClassName( componentClass);
		if ( i.componentTypes.exists( className))
		{
			type =  i.componentTypes.get( className);
		}
		else
		{
			var bits = new BitSet();
			
			i.numTypes++;
			bits.set( i.numTypes, 1);
			
			type = new ComponentType( componentClass, bits);
			i.componentTypes.set( className, type);
		}
		
		return type;
	}
	
}