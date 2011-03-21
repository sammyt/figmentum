package lang {
    
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
            var out:Object = Reader.read(input);
            trace(out);
            assertNotNull(out);
        }
        
        [Test]
        public function returnsSeq():void {
            var input:IInput = new StringInput("(a)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertTrue(out is ISeq);
            
            var seq:ISeq = ISeq(out);
            
            assertTrue(seq.first is Array);
            assertTrue(seq.first.length == 1);
        }
    }
}

