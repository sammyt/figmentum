package lang
{

public final class Cons implements ISeq
{
    private var _first:Object;
    private var _rest:ISeq;
    
	public function Cons(first:Object, rest:ISeq)
	{
	    _first = first;
	    _rest = rest;
	}
	
	public function get first():Object
	{
	    return _first;
	}
	
	public function get rest():ISeq
	{
	    return _rest;
	}
	
	public function cons(obj:Object):ISeq
	{
	   return new Cons(obj, this);
	}
}

}

