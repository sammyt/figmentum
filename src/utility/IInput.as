package utility
{

public interface IInput
{
    function charsMatching(re:RegExp):String;
	function nextChar():String;
	function nextCode():Number;
	function get pos():int;
	function backup():void;
}

}

