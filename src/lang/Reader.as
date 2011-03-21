package lang 
{

import utility.*;
import flash.utils.Dictionary;

public class Reader 
{
    private var _input:IInput;
        
    public function Reader(input:IInput) 
    {
        _input = input;
    }
    
    public function read():Object
    {
        var char:uint = _input.nextCode();
        
        while(true)
        {
            var reader:Function = macros[char] as Function;
            if(reader != null)
            {
                return reader(_input);
            }
            else
            {
                readToken(_input);
            }
        }
        return null;
    }
    
    
    private static const macros:Dictionary = dictFrom(
        Chars.LPAREN, function(input:IInput):Object { return readList(input, Chars.RPAREN);}
    )
    
    public static function readList(input:IInput, endChar:uint):ISeq
    {
        return new Cons(null, null);
    }
    
    public static function readToken(input:IInput):Object
    {
        input.nextCode();
        return "a";
    }
}

}