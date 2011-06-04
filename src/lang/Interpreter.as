package lang {

import leafy.*;
import utility.*;

import flash.utils.Dictionary;

public class Interpreter  {
    
    private static const specials:Dictionary = dictFrom(
        "def", defExpr,
        "fn", fnExpr
    );
    
    private static function findSpecial(seq:ISeq):Function {
        trace("specials", seq.first);
        return specials[seq.first];
    }
    
    public function eval(form:Object):* {
        return _eval(form);
    }
    
    private static function _eval(form:*):Object {
        trace("expr", form);
        if(form is ISeq) {
            var special:Function = findSpecial(form);
            if(special != null) {
                return special(form);
            }
            if(form is IMap) {
                return form; 
            }
            if(form is IVect) {
                return form;
            }
            throw new Error("Seq fail" + form);
        } else if(isKeyword(form)) {
            return keywordExpr(form);
        } else if(isStr(form)) {
            return strExpr(form);
        } else if(isSymbol(form)) {
            return symbolExpr(form);
        }
        throw new Error("Whats this? " + form);
    }
    
    private static function isKeyword(obj:*):Boolean {
        return (obj is String && String(obj).charCodeAt(0) == Chars.COLON);
    }
    
    private static function isStr(obj:*):Boolean {
        return (obj is String && String(obj).charCodeAt(0) == Chars.SPEACH);
    }
    
    private static function isSymbol(obj:*):Boolean {
        return (obj is String);
    }
    
    private static function defExpr(form:*):Object {    
        form = form.rest
        var ref:Ref = Ref.named(form.first);
        ref.value = _eval(form.rest.first);
        return ref;
    }
    
    private static function fnExpr(form:*):Object {    
        return null;
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


