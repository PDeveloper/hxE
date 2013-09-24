package hxE.bits;

/**
 * ...
 * @author P Svilans
 */
class DynamicBitSet
{
	
	private var bitLength:Int;
	
	private var fields:Array<Int>;
	
	private var size:Int;

	public function new() 
	{
		fields = new Array<Int>();
		
		size = 0;
		setSize( 1);
	}
	
	public function flip():Void
	{
		for ( i in 0...fields.length) fields[i] = ~fields[i];
	}
	
	public function set( bit:Int, value:Int):Void
	{
		bit -= 1;
		var _field:Int = bit >> 5;
		var _bit:Int = bit - (_field << 5);
		
		if ( _field + 1 > size) size = _field + 1;
		
		fields[_field] |= value << _bit;
	}
	
	public function setTrue( bit:Int):Void
	{
		bit -= 1;
		var _field:Int = bit >> 5;
		var _bit:Int = bit - (_field << 5);
		
		if ( _field + 1 > size) size = _field + 1;
		
		fields[_field] |= 1 << _bit;
	}
	
	public function setFalse( bit:Int):Void
	{
		bit -= 1;
		var _field:Int = bit >> 5;
		var _bit:Int = bit - (_field << 5);
		
		if ( _field + 1 > size) size = _field + 1;
		
		fields[_field] &= ~(1 << _bit);
	}
	
	public inline function get( bit:Int):Int
	{
		bit -= 1;
		var _field:Int = bit >> 5;
		var _bit:Int = bit - (_field << 5);
		
		if ( _field + 1 > size) size = _field + 1;
		
		return ( fields[_field] >> _bit) & 1;
	}
	
	public function add( bits:DynamicBitSet):DynamicBitSet
	{
		var len:Int = Std.int( Math.min( size, bits.size));
		
		for ( i in 0...len)
		{
			fields[i] |= bits.fields[i];
		}
		
		return this;
	}
	
	public function sub( bits:DynamicBitSet):DynamicBitSet
	{
		var len:Int = Std.int( Math.min( size, bits.size));
		
		for ( i in 0...len)
		{
			fields[i] &= ~bits.fields[i];
		}
		
		return this;
	}
	
	public function contains( bits:DynamicBitSet):Bool
	{
		var len:Int = Std.int( Math.min( size, bits.size));
		
		for ( i in 0...len)
		{
			if ( ( fields[i] & bits.fields[i]) != bits.fields[i])
			{
				return false;
			}
		}
		
		for ( i in len...bits.getSize())
		{
			if ( bits.fields[i] > 0)
			{
				return false;
			}
		}
		
		return true;
	}
	
	public function equals( bits:DynamicBitSet):Bool
	{
		var biggest:DynamicBitSet;
		var smallest:DynamicBitSet;
		var len:Int;
		
		if ( bits.getSize() > size)
		{
			biggest = bits;
			smallest = this;
			len = bits.getSize();
		}
		else
		{
			biggest = this;
			smallest = bits;
			len = size;
		}
		
		for ( i in 0...smallest.getSize())
			if ( fields[i] != bits.fields[i])
			{
				return false;
			}
		
		for ( i in smallest.getSize()...biggest.getSize())
			if ( biggest.fields[i] > 0)
			{
				return false;
			}
		
		return true;
	}
	
	public function reset():Void
	{
		for ( i in 0...fields.length) fields[i] = 0;
	}
	
	public function getSize():Int
	{
		return size;
	}
	
	public function setSize( newSize:Int):Void
	{
		for ( i in size...newSize) fields[i] = 0;
		size = newSize;
		
		bitLength = 32 * newSize;
	}
	
	public function toString():String
	{
		var output = "";
		for ( field in fields)
		{
			for ( i in 0...32)
			{
				output = Std.string( ( field >> i) & 1) + output;
			}
		}
		return output;
	}
	
}