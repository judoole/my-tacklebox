package mockremote {
import domain.Person;

import mx.rpc.remoting.test.RemoteObjectStub;

import org.hamcrest.core.isA;

public class MockPersonServiceRemote extends RemoteObjectStub {
    public function MockPersonServiceRemote(destination:String=null) {
        super(destination);
        delay = 3000;
        this.result("save", [isA(Person)], savedPerson());
    }

    private function savedPerson():Person {
        var person:Person = new Person();
        person.id = 1000;
        person.name = "Newly Saved Person";

        return person;
    }
}
}