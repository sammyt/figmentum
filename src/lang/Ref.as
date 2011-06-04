package lang {

public class Ref {
    
    public var name:String;
    public var value:*;
    
    public function Ref(name:String = "", value:* = null) {
        this.name = name;
        this.value = value;
        
        trace("Created Ref(name:"+name+")");
    }
    
    public static function named(name:String):Ref {
        return new Ref(name);
    }
}
}

