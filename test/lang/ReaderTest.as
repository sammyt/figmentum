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
            assertThat(list.first, equalTo("something"));   
        }
        
        [Test]
        public function symbolInLongerSeq():void {
            var input:IInput = new StringInput("(:something :other (:and-another))");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            var list:List = List(out);
            assertThat(list.first, equalTo("something"));   
            assertThat(list.rest.first, equalTo("other"));
            
            var rest:ISeq = list.rest.rest;
            assertThat(rest.first.first, equalTo("and-another"));
            assertThat(rest.first.rest, equalTo(List.EMPTY_LIST));
        }
        
        [Test]
        public function aString():void {
            var input:IInput = new StringInput('"some content"');
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(String));
            assertThat(out, equalTo("\"some content\""));
        }
        
        [Test]
        public function moreStrings():void {
            var input:IInput = new StringInput('("some content", "bacon")');
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            assertThat(out.first, equalTo("\"some content\""));
            assertThat(out.rest.first, equalTo("\"bacon\""));
        }
        
        [Test]
        public function moreStringsAndSymbols():void {
            var input:IInput = new StringInput('("some content", :sausage)');
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            assertThat(out.first, equalTo("\"some content\""));
            assertThat(out.rest.first, equalTo("sausage"));
        }
        
        [Test]
        public function aNumber():void {
            var input:IInput = new StringInput("4");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(Number));
            assertThat(out, equalTo(4));
        }
        
        [Test]
        public function aDecimalNumber():void {
            var input:IInput = new StringInput("4.989");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(Number));
            assertThat(out, equalTo(4.989));
        }
        
        [Test]
        public function nestedNumberes():void {
            var input:IInput = new StringInput("(4.989 55)");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            assertThat(out.first, equalTo(4.989));
            assertThat(out.rest.first, equalTo(55));
        }
        
        [Test]
        public function moreNestedNumberes():void {
            var input:IInput = new StringInput("(4.989 (:woo))");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(List));
            assertThat(out.first, equalTo(4.989));
            assertThat(out.rest.first.first, equalTo("woo"));
        }
        
        [Test]
        public function vector():void {
            var input:IInput = new StringInput("[]");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(Vect));   
        }
        
        [Test]
        public function vectorWithContent():void {
            var input:IInput = new StringInput("[:a :b]");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(Vect));
            assertThat(out.count, equalTo(2));
        }
        
        [Test]
        public function readsMap():void {
            var input:IInput = new StringInput("{}");
            var out:Object = Reader.read(input);
            assertNotNull(out);
            assertThat(out, isA(Map));
            assertThat(out, equalTo(Map.EMPTY_MAP));
        }
        
        [Test]
        public function demo():void {
            for(var i:int = 100; i > -1; i--) {
                trace(i & 31, 0x01f); // 11111 in binary
            }
        }
    }
}

