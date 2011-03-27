package lang
{

public final class Vect implements ISeq {
	
	private var source:Array;
	
	public function Vect(source:Array) {
		super();
		
		this.source = source;
	}
	
	public function nth(n:uint):Object {
	   return source[n];
	}
	
	public function get first():Object {
	    return nth(0);
	}
	
	public function get rest():ISeq {
	    var tmp:Array = source.concat();
	    tmp.shift()
	    return new Vect(tmp);
	}
	
	public function cons(obj:Object):ISeq {
	   return new Vect(source.concat(obj));
	}
	
	public function get count():int {
	    return source.length;
	}
	
	public function toString():String {
	   return "[Vector [" + source + "]]";
	}
    
    
    public static function fromArray(source:Array):Vect {
        return new Vect(source);
    }
}

}

