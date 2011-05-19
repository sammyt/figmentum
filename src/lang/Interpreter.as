package lang {

public class Interpreter  {
    
    public function interpret(form:Object):void {
        if(form is ILinkedList) {
            
        }
    }
}

}

import leafy.*;
import lang.*;

class Fn implements IFn {
    
    public var name:String;
    public var body:ILinkedList;
    
    public static function from(name:String, body:ILinkedList):Fn {
        var fn:Fn = new Fn();
        fn.name;
        fn.body = body;
        return fn;
    }
    
    public function call(...args):Object {
        var arity:int = args.length;
        
        return null;
    }
    
}