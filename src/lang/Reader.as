package lang 
{

import utility.*;
import flash.utils.Dictionary;

public class Reader  {
    
    public static function read(input:IInput):Object {
        var char:uint = input.nextCode();
        while(true) {
            var reader:Function = macros[char] as Function;
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
    
    
    private static const macros:Dictionary = dictFrom(
        Chars.LPAREN, function(input:IInput):Object { 
            return readList(input, Chars.RPAREN);
        },
        Chars.COLON, function(input:IInput):Object { 
            return readSymbol(input);
        }
    )
    
    public static function readSymbol(input:IInput):Object {
        var word:String = input.charsMatching(/[\w-]+/);
        
        if(word) {
            return word;
        }
        return null;
    }
    
    public static function readList(input:IInput, endChar:Number):ISeq {
        var list:Array = readDelimitedList(Chars.RPAREN, input);
        return List.fromArray(list);
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
    		
    		if(isNaN(char))
    		{
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