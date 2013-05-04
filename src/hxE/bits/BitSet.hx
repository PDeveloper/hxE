package hxE.bits;

/**
 * ...
 * @author P Svilans
 */
typedef BitSet =
#if hxELargeBit
LargeBitSet;
#elseif hxEDoubleBit
DoubleBitSet;
#else
SingleBitSet;
#end
