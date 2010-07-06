package inspirado.application.objects {
import inspirado.beans.InitializingBean;

public class MySimpleClass implements InitializingBean{
    public var name:String;
    public var afterCreationCompleteCalled:Boolean = false;

    public function MySimpleClass(name:String) {
        this.name=name;
    }

    public function afterCreationComplete():void {
        afterCreationCompleteCalled = true;
    }
}
}