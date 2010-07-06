package application {
import application.objects.MySimpleClass;

import org.flexunit.asserts.assertEquals;

public class DynamicApplicationTest {
    [After]
    public function removeAllBeans() : void{
        DynamicApplication.removeAllBeans();
    }

    [Test]
    public function shouldAddValueObjectAndGiveIdEqualToClassName() : void{
        var value:MySimpleClass = new MySimpleClass("someName");

        DynamicApplication.addBean("mySimpleClass", value);
        assertEquals(value, DynamicApplication.getBeanById("mySimpleClass"));
    }

    [Test(expects="application.error.BeanNotFoundError")]
    public function shouldThrowErrorIfBeanNotFound() : void{
        DynamicApplication.getBeanById("does not exists", true);
    }
}
}