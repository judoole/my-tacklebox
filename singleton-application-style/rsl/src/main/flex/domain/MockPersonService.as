package domain {
import application.ServerCommunication;

import service.PersonService;

public class MockPersonService implements PersonService{
    public var saveCalled:Boolean = false;
    public function save(person:Person, successFunction:Function, faultFunction:Function, serverCommunication:ServerCommunication) : void {
        saveCalled = true;
    }
}
}