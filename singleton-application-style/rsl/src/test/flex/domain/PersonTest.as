package domain {
import application.DynamicApplication;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;

import service.PersonService;

public class PersonTest {
    [Test]
    public function shouldInjectCorrectPersonService() : void{
        var mock:MockPersonService = new MockPersonService();
        DynamicApplication.addService("personService", mock);

        var person:Person = new Person();
        person.save();

        assertEquals(mock, person.service);
    }
}
}