package lang
{

public interface ISeq
{
	function get first():Object;
	function get rest():ISeq;
	function cons(obj:Object):ISeq;
}

}

