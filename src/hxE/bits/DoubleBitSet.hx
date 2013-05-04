package hxE.bits;

/**
 * ...
 * @author P Svilans
 */
class DoubleBitSet implements IBitSet
{
	
	private var _bits0:Int;
	private var _bits1:Int;

	public function new() 
	{
		_bits0 = 0;
		_bits1 = 0;
	}
	
	public function flip():Void
	{
		_bits0 = ~_bits0;
		_bits1 = ~_bits1;
	}
	
	public inline function set( bit:Int, value:Int):Void
	{
		if ( bit < 33) _bits0 |= value << ( bit - 1);
		else _bits1 |= value << ( bit - 33);
	}
	
	public function add( bits:BitSet):BitSet
	{
		_bits0 |= bits._bits0;
		_bits1 |= bits._bits1;
		return this;
	}
	
	public function sub( bits:BitSet):BitSet
	{
		_bits0 &= ~bits._bits0;
		_bits1 &= ~bits._bits1;
		return this;
	}
	
	public inline function contains( bits:BitSet):Bool
	{
		if (_bits0 & bits._bits0 != bits._bits0 ||
			_bits1 & bits._bits1 != bits._bits1 ) return false;
		
		return true;
	}
	
	public inline function equals( bits:BitSet):Bool
	{
		if ( _bits0 != bits._bits0 || _bits1 != bits._bits1) return false;
		return true;
	}
	
	public function reset():Void
	{
		_bits0 = 0;
		_bits1 = 0;
	}
	
	public function toString():String
	{
		var output = "";
		
		for ( i in 0...32) output = Std.string( ( _bits0 >> i) & 1) + output;
		for ( i in 0...32) output = Std.string( ( _bits1 >> i) & 1) + output;
		
		return output;
	}
	
}