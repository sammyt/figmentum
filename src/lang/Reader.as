package lang 
{

import utility.*;
import flash.utils.Dictionary;

public class Reader  {
    
    public static function read(input:IInput):Object {
        var code:uint = input.nextCode();
        while(true) {
            
            if(isNumber(code)) {
                return readNumber(input);
            }
            
            var reader:Function = macros[code] as Function;
            if(reader != null) {
                return reader(input);
            }
            else {
                input.backup();
                return readToken(input);
            }
        }
        return null;
    }
    
    public static function isNumber(code:uint):Boolean {
        return code >= 48 && code <= 57;
    }
    
    public static const macros:Dictionary = dictFrom(
        Chars.LPAREN, readList,
        Chars.LGULL, readMap,
        Chars.LBRACE, readVector,
        Chars.COLON, readSymbol,
        Chars.SPEACH, readString
    );
    
    public static function readNumber(input:IInput):Object {
        input.backup();
        
        var digits:String = input.charsMatching(/[0-9]+(?:\.[0-9]*)?/);

        if(digits) {
            return Number(digits);
        }
        return null;
    }
    
    public static function readString(input:IInput):Object {
        input.backup();
        
        var word:String = input.charsMatching(/"(?:\.|(\\\")|[^\""\n])*"/);

        if(word) {
            return word;
        }
        return null;
    }
    
    public static function readSymbol(input:IInput):Object {
        var word:String = input.charsMatching(/[\w-]+/);
        
        if(word) {
            return word;
        }
        return null;
    }
    
    public static function readList(input:IInput):ISeq {
        var list:Array = readDelimitedList(Chars.RPAREN, input);
        return List.fromArray(list);
    }
    
    public static function readMap(input:IInput):ISeq {
        var list:Array = readDelimitedList(Chars.RGULL, input);
        return Map.fromArray(list);
    }
    
    public static function readVector(input:IInput):ISeq {
        var list:Array = readDelimitedList(Chars.RBRACE, input);
        return Vect.fromArray(list);
    }
    
    public static function readToken(input:IInput):Object {
        return input.nextCode();
    }
    
    private static function readDelimitedList(endChar:Number, input:IInput):Array {
        var list:Array = [];
        
        while(true) {
            
            var char:Number = input.nextCode();
            
            while(isWhiteSpace(char)) {
                char = input.nextCode();
            }
            
            if(char == endChar)
    			break;
    		
    		if(isNaN(char)) {
    		    throw new Error("EOF");
    		}
            
            input.backup();
            list.push(read(input));
        }
        return list;
    }
    
    private static function isWhiteSpace(char:Number):Boolean {
        return (char == Chars.SPACE || char == Chars.COMMA);
    }
}

}