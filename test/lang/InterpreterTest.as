package lang  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    
    import utility.*;
    import lang.*;
    import leafy.*;

    public class InterpreterTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:Interpreter;

        [Before]
        public function setUp():void {
            instance = new Interpreter();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is Interpreter", instance is Interpreter);
        }
        
        [Test]
        public function def():void {
            var form:* = Reader.read(new StringInput("(def thing \"a\")"));
            var ans:* = instance.eval(form);
            
            assertThat(ans, isA(Ref));
            assertThat(ans.value, equalTo("\"a\""));
            assertThat(ans.name, equalTo("thing"));
        }
        
        [Test]
        public function defMap():void {
            var form:* = Reader.read(new StringInput("(def thing {:a 1})"));
            var ans:* = instance.eval(form);
            
            assertThat(ans, isA(Ref));
            assertThat(ans.value, isA(IMap));
            assertThat(ans.name, equalTo("thing"));
            
            var map:IMap = ans.value as IMap;
            assertThat(map.at(":a"), equalTo(1));
        }
        
        [Test]
        public function fn():void {
            var form:* = Reader.read(new StringInput("(fn [] ())"));
            var ans:* = instance.eval(form);
            
            assertThat(ans, isA(IFn));
            var res:Object = ans.call();
            assertThat(res, isA(ILinkedList));
            assertThat(res.count, equalTo(0));
        }
        
        [Test]
        public function fnStr():void {
            var form:* = Reader.read(new StringInput("(fn [] \"umm\")"));
            var ans:* = instance.eval(form);
            
            assertThat(ans, isA(IFn));
            var res:Object = ans.call();
            assertThat(res, isA(String));
            assertThat(res, equalTo("\"umm\""));
        }
        
        [Test]
        [Ignore]
        public function fnArg():void {
            var form:* = Reader.read(new StringInput("(fn [a] a)"));
            var ans:* = instance.eval(form);
            
            assertThat(ans, isA(IFn));
            var res:Object = ans.call(1);
            assertThat(res, isA(Number));
            assertThat(res, equalTo(1));
        }
    }
}

