package lang {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    
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
            assertThat(out, isA(ISeq));
            assertThat(out, equalTo(List.EMPTY_LIST));
        }
        
        [Test]
        public function returnsSeq():void {
            var input:IInput = new StringInput("(a b c d)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            
            var seq:ISeq = ISeq(out);   
        }
        
        [Test]
        public function returnsNestedSeq():void {
            var input:IInput = new StringInput("(a (b c d))");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
        }
        
        [Test]
        public function countSeq():void {
            var input:IInput = new StringInput("(a c d)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            var list:List = List(out);
            
            assertThat(list.count, equalTo(3));
        }
        
        [Test]
        public function countNestedSeq():void {
            var input:IInput = new StringInput("(a (b c d) (g) d)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            var list:List = List(out);
            
            assertThat(list.count, equalTo(4));
        }
        
        [Test]
        public function symbol():void {
            var input:IInput = new StringInput(":something");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(String));
            assertThat(out, equalTo("something"));
        }
        
        [Test]
        public function symbolInSeq():void {
            var input:IInput = new StringInput("(:something)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            var list:List = List(out);
            trace(list);
            assertThat(list.first, equalTo("something"));
        }
    }
}

