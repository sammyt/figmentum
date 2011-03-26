package utility
{

public final class StringInput implements IInput {
    private var _input:String;
    private var _pos:int;
    
    public function StringInput(input:String, pos:int = 0) {
        _input = input;
        _pos = pos;
    }
    
    public function charsMatching(re:RegExp):String {
        var str:String = _input.substring(_pos);
        var result:Array = str.match(re);
        
        if(result.length) {
            var match:String = result[0];
            _pos += match.length;
            return match;    
        }
        return "";
    }
    
	public function nextChar():String {
	    var ch:String = _input.charAt(pos);
	    _pos++;
	    return ch;
	}
	
	public function nextCode():Number {
	    var code:Number = _input.charCodeAt(pos);
        _pos++;
	    return code;
	}
	
	public function get pos():int {
	    return _pos;
	}
	
	public function backup():void {
	    _pos--;
	}
}

}

