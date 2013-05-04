package hxE.bits;

/**
 * ...
 * @author P Svilans
 */
interface IBitSet
{
	
	public function flip():Void;
	
	public function set( bit:Int, value:Int):Void;
	
	public function add( bits:BitSet):BitSet;
	
	public function sub( bits:BitSet):BitSet;
	
	public function contains( bits:BitSet):Bool;
	
	public function equals( bits:BitSet):Bool;
	
	public function reset():Void;
	
	public function toString():String;
	
}