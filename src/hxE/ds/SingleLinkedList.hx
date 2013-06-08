package hxE.ds;

/**
 * ...
 * @author P Svilans
 */
@:generic class SingleLinkedList <T>
{
	
	private var _begin:SingleLinkedSlot<T>;
	private var _end:SingleLinkedSlot<T>;
	
	public var head:SingleLinkedSlot<T>;
	public var tail:SingleLinkedSlot<T>;
	
	public var size:Int;
	
	private var _iter:SingleLinkedIterator<T>;
	
	public var reuse:Bool;
	
	public function new() 
	{
		_begin	= new SingleLinkedSlot<T>(null);
		_end	= new SingleLinkedSlot<T>(null);
		_begin.next = _end;
		
		_iter = new SingleLinkedIterator<T>( _begin, _end);
		
		head = _begin;
		tail = _begin;
		
		reuse = false;
		
		size = 0;
	}
	
	public function push_back( value:T):Void
	{
		var slot = new SingleLinkedSlot<T>( value);
		
		slot.next = _end;
		
		tail.next = slot;
		tail = slot;
		
		size++;
	}
	
	public function push_front( value:T):Void
	{
		var slot = new SingleLinkedSlot<T>( value);
		
		_begin.next = slot;
		
		slot.next = head;
		head = slot;
		
		size++;
	}
	
	public function pop_back():T
	{
		var v:T = tail.value;
		
		var current = _begin;
		while ( current.next != tail) current = current.next;
		current.next = _end;
		
		tail = null;
		
		size--;
		
		return v;
	}
	
	public function pop_front():T
	{
		var v:T = head.value;
		_begin.next = head.next;
		
		head = null;
		
		size--;
		
		return v;
	}
	
	public function isEmpty():Bool
	{
		return _begin.next == _end;
	}
	
	public function clear():Void
	{
		_begin.next = _end;
		size = 0;
	}
	
	public function remove( value:T):Void
	{
		var current = _begin;
		while ( current.next != _end)
		{
			if ( current.next.value == value)
			{
				current.next = current.next.next;
				size--;
				return;
			}
			else current = current.next;
		}
	}
	
	public function removeAll( value:T):Void
	{
		var current = _begin;
		while ( current.next != _end)
		{
			if ( current.next.value == value)
			{
				current.next = current.next.next;
				size--;
			}
			else current = current.next;
		}
	}
	
	public function iterator():Iterator<T>
	{
		if ( reuse) _iter.reset();
		else _iter = new SingleLinkedIterator<T>( _begin, _end);
		
		return _iter;
	}
	
}

@:generic class SingleLinkedIterator <T>
{
	
	private var _c:SingleLinkedSlot<T>;
	private var _n:SingleLinkedSlot<T>;
	
	private var _b:SingleLinkedSlot<T>;
	private var _e:SingleLinkedSlot<T>;
	
	public function new( _b:SingleLinkedSlot<T>, _e:SingleLinkedSlot<T>)
	{
		this._b = _b;
		this._e = _e;
		
		this._c = _b;
		this._n = _b.next;
	}
	
	public function reset():Void
	{
		this._c = _b;
		this._n = _b.next;
	}
	
	public function hasNext():Bool
	{
		return _n != _e;
	}
	
	public function next():T
	{
		_c = _n;
		_n = _c.next;
		
		return _c.value;
	}
	
}

@:generic class SingleLinkedSlot <T>
{
	
	public var next:SingleLinkedSlot<T>;
	
	public var value:T;
	
	public function new( value:T)
	{
		this.value = value;
	}
}