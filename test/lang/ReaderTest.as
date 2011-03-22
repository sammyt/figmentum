package lang {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.isA;
    
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
            assertNotNull(out);
        }
        
        [Test]
        public function returnsSeq():void {
            var input:IInput = new StringInput("(a)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(ISeq));
            
            var seq:ISeq = ISeq(out);
            
            
        }
    }
}

