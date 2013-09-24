package hxE.bits;

/**
 * ...
 * @author P Svilans
 */
class SingleBitSet implements IBitSet
{
	
	public static var bitLength:Int = 32;
	
	private var _bits:Int;

	public function new() 
	{
		_bits = 0;
	}
	
	public function flip():Void
	{
		_bits = ~_bits;
	}
	
	public inline function set( bit:Int, value:Int ):Void
	{
		_bits |= value << ( bit - 1);
	}
	
	public inline function get( bit:Int ):Int
	{
		return ( _bits >> (bit - 1)) & 1;
	}
	
	public function add( bits:BitSet ):BitSet
	{
		_bits |= bits._bits;
		return this;
	}
	
	public function sub( bits:BitSet ):BitSet
	{
		_bits &= ~bits._bits;
		return this;
	}
	
	public function contains( bits:BitSet ):Bool
	{
		if ( _bits & bits._bits != bits._bits) return false;
		return true;
	}
	
	public function equals( bits:BitSet):Bool
	{
		if ( _bits != bits._bits) return false;
		return true;
	}
	
	public function reset():Void
	{
		_bits = 0;
	}
	
	public function toString():String
	{
		var output = "";
		
		for ( i in 0...32)
		{
			output = Std.string( ( _bits >> i) & 1) + output;
		}
		
		return output;
	}
	
}