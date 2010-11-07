package inspirado.application {
import flash.utils.Dictionary;

import inspirado.application.objects.VanillaInterface1;
import inspirado.application.objects.VanillaObject;
import inspirado.application.objects.VanillaObjectWithImplementations;

import org.as3commons.lang.DictionaryUtils;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertStrictlyEquals;

public class ApplicationContextTest {

    [After]
    [Before]
    public function cleanUp():void {
        ApplicationContext.objects = new Dictionary();
    }

    [Test]
    public function shouldBeAbleToAddObjectWithId():void {
        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(new VanillaObject("2"), "myVanilla");
        assertEquals(2, DictionaryUtils.getKeys(ApplicationContext.objects).length);
    }

    [Test]
    public function shouldBeAbleToAddObjectWithImplementation():void {
        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(new VanillaObjectWithImplementations(), "myVanilla");
        assertEquals(4, DictionaryUtils.getKeys(ApplicationContext.objects).length);
    }

    [Test]
    public function shouldBeAbleToGetWithId():void {
        var instance:VanillaObjectWithImplementations = new VanillaObjectWithImplementations();

        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(instance, "myVanilla");
        assertEquals(instance, ApplicationContext.getObjectById("myVanilla"));
    }

    [Test]
    public function shouldBeAbleToGetBasedOnId():void {
        var instance:VanillaObject = new VanillaObject("5");

        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(instance);
        assertEquals(instance, ApplicationContext.getObjectByType(VanillaObject));
    }

    [Test]
    public function shouldBeAbleToGetBasedOnImplementation():void {
        var instance:VanillaObjectWithImplementations = new VanillaObjectWithImplementations();

        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(instance);
        assertEquals(instance, ApplicationContext.getObjectByType(VanillaInterface1));
    }

    [Test]
    public function shouldBeAbleToGetBasedOnClass():void {
        var instance:VanillaObject = new VanillaObject();

        assertEquals(0, DictionaryUtils.getKeys(ApplicationContext.objects).length);
        ApplicationContext.addObject(instance);
        assertEquals(instance, ApplicationContext.getObjectByType(VanillaObject));
    }

    [Test(expects="inspirado.application.error.ApplicationContextError")]
    public function shouldThrowErrorIfTryingToGetByClassAndThereExistsMultipleImplementations():void {
        var instance:VanillaObject = new VanillaObject();
        var instance2:VanillaObject = new VanillaObject();

        ApplicationContext.addObject(instance);
        ApplicationContext.addObject(instance2);
        ApplicationContext.getObjectByType(VanillaObject);
    }
}
}