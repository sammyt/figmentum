package lang
{

public class List implements ISeq {
	public static const EMPTY_LIST:List = new List(null, null);
	
	private var _first:Object;
    private var _rest:ISeq;
    private var _count:int;
    
    public function List(first:Object, rest:ISeq, count:int = 0) {
		super();
		
		_first = first;
		_rest = rest;
		_count = count;
	}
    
    
	public function get first():Object {
	    return _first;
	}
	
	public function get rest():ISeq {
	    return _rest;
	}
	
	public function cons(obj:Object):ISeq {
	   return new List(obj, this, _count + 1);
	}
	
	public function get count():int {
	    return _count;
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

