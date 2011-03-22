package lang
{

public class List implements ISeq
{
	public static const EMPTY_LIST:List = new List(null, null);
	
	private var _first:Object;
    private var _rest:ISeq;
    
    public function List(first:Object, rest:ISeq) {
		super();
		
		_first = first;
		_rest = rest;
	}
    
    
	public function get first():Object {
	    return _first;
	}
	
	public function get rest():ISeq {
	    return _rest;
	}
	
	public function cons(obj:Object):ISeq {
	   return new List(obj, this);
	}
	
	public function toString():String {
	   return "[List first:" + _first + " rest:" + rest + "]";
	}
    
	static public function fromArray(source:Array):ISeq {
	    
	    var list:List = EMPTY_LIST;
	    
	    for each(var item:Object in source) {
	        list = list.cons(item) as List;
	    }
	    
	    return list;
	}
}

}

