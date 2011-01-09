package utility
{
import flash.utils.Dictionary;

public function dictFrom(...pairs):Dictionary
{
    var dict:Dictionary = new Dictionary();
    var key:Object;
    for (var i:int = 0; i < pairs.length; i++)
    {
        if(i % 2 == 0)
        {
            key = pairs[i];
        }
        else
        {
            dict[key] = pairs[i];
        }
    }
    return dict;
}

}

