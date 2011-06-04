package lang
{   

import leafy.*;
import utility.*;

public class Fn implements IFn
{
    public var params:IVect;
    public var body:Object;
    public var apply:Function;
    
    public function Fn()
    {
        super();
    }
    
    public function call(...args):Object {
        return apply();
    }
}
}