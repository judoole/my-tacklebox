package domain {
import application.DynamicApplication;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;

public class PersonTest {
    [Test]
    public function shouldInjectCorrectPersonService() : void{
        var mock:MockPersonService = new MockPersonService();
        DynamicApplication.addBean("personRepo", mock);

        var person:Person = new Person();
        assertEquals(mock, person.service);
        person.save();
        assertTrue(mock.saveCalled);
    }
}
}