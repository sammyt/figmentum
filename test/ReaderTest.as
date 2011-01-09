package  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;
    import utility.*;
    import lang.*;

    public class ReaderTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;
        
        [Test]
        public function returnsEmptySeq():void {
            var input:IInput = new StringInput("()");
            var reader:Reader = new Reader(input);
            
            var out:Object = reader.read();
            assertNotNull(out);
            
        }
        
        [Test]
        public function returnsSeq():void {
            var input:IInput = new StringInput("(a)");
            var reader:Reader = new Reader(input);
            
            var out:Object = reader.read();
            assertNotNull(out);
        }
    }
}

