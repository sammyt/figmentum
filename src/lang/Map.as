package lang
{

public final class Map implements ISeq {
    
    public static const EMPTY_MAP:Map = new Map();
    
    public function get first():Object {
        return null;
    }
    
	public function get rest():ISeq {
	    return null;
	}
	
	public function cons(obj:Object):ISeq {
	    return null;
	}
	
	public function assoc(key:Object, value:Object):Map {
	    return null;
	}
	
	public static function fromArray(source:Array):Map {
	    
        var map:Map = EMPTY_MAP;
        var key:Object;
        for (var i:int = 0; i < source.length; i++) {
            if(i % 2 == 0) {
                key = source[i];
            }
            else {
                var value:Object = source[i];
                map = map.assoc(key, value);
            }
        }
        return map;
	}
}

}

