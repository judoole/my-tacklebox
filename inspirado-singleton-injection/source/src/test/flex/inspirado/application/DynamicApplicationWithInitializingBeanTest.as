package inspirado.application {
import inspirado.application.objects.MySimpleClass;

import mx.events.FlexEvent;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;
import org.fluint.uiImpersonation.UIImpersonator;

public class DynamicApplicationWithInitializingBeanTest {
    private var myClass:MySimpleClass = new MySimpleClass("myName");

    [After]
    public function removeAllBeans() : void{
        DynamicApplication.removeAllBeans();
    }
    [Before(async, ui)]
    public function waitForCreationComplete() : void{
        var application:DynamicApplication = new DynamicApplication();
        Async.proceedOnEvent( this, application, FlexEvent.CREATION_COMPLETE, 1000 );
        DynamicApplication.addBean("myBean", myClass);
        UIImpersonator.addChild(application);
    }

    [Test]
    public function shouldRunInitializingMethodAfterCreationComplete() : void{
        assertTrue(DynamicApplication.getBeanById("myBean", true).afterCreationCompleteCalled);
    }
}
}