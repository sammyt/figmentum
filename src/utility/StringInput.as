package utility
{

public final class StringInput implements IInput
{
    private var _input:String;
    private var _pos:int;
    
    public function StringInput(input:String, pos:int = 0)
    {
        _input = input;
        _pos = pos;
    }
    
	public function nextChar():String
	{
	    var ch:String = _input.charAt(pos);
	    _pos++;
	    return ch;
	}
	
	public function nextCode():uint
	{
	    var code:uint = _input.charCodeAt(pos);
        _pos++;
	    return code;
	}
	
	public function get pos():int
	{
	    return _pos;
	}
}

}

