package {
    import asunit.core.TextCore;
    import flash.display.MovieClip;

    public class SeqroRunner extends MovieClip {
        
        private var core:TextCore;

        public function SeqroRunner() {
            core = new TextCore();
            // You can run a single Test Case with:
            // core.start(SomeTest, null, this);
            // Or a single test method with:
            // core.start(SomeTest, 'testMethod', this);
            core.start(AllTests, null, this);
        }
    }
}

