package lang {

import leafy.*;
import utility.*;

import flash.utils.Dictionary;

public class Interpreter  {
    
    private const specials:Dictionary = dictFrom(
        "def", defExpr,
        "fn", fnExpr
    );
    
    private function findSpecial(seq:ISeq):Function {
        return specials[seq.first];
    }
    
    public function eval(form:Object):* {
        if(form is ISeq) {
            var special:Function = findSpecial(form as ISeq);
            if(special != null) {
                return special(form);
            }
            if(form is IMap) {
                return form; 
            }
            if(form is IVect) {
                return form;
            }
            if(form is ILinkedList) {
                return form;
            }
        } else if(isKeyword(form)) {
            return keywordExpr(form as String);
        } else if(isStr(form)) {
            return strExpr(form as String);
        } else if(isSymbol(form)) {
            return symbolExpr(form as String);
        }
        throw new Error("Whats this? " + form);
    }
    
    private function isKeyword(obj:*):Boolean {
        return (obj is String && String(obj).charCodeAt(0) == Chars.COLON);
    }
    
    private function isStr(obj:*):Boolean {
        return (obj is String && String(obj).charCodeAt(0) == Chars.SPEACH);
    }
    
    private function isSymbol(obj:*):Boolean {
        return (obj is String);
    }
    
    private function defExpr(form:*):Object {    
        form = form.rest
        var ref:Ref = Ref.named(form.first);
        ref.value = eval(form.rest.first);
        return ref;
    }
    
    private function fnExpr(form:*):Object {
        form = form.rest
        var fn:Fn = new Fn();
        fn.params = eval(form.first) as IVect;
        fn.apply = function(...args):* {
            return eval(form.rest.first);
        };
        return fn;
    }
    
    private static function strExpr(value:String):Object {
        return value;
    }
    
    private static function symbolExpr(value:String):Object {
        return value;
    }
    
    private static function keywordExpr(value:String):Object {
        return value;
    }
}

}


