package domain {
import application.ServerCommunication;

import domain.repository.PersonRepository;

public class MockPersonService implements PersonRepository{
    public var saveCalled:Boolean = false;

    public function save(person:Person, successFunction:Function=null, faultFunction:Function=null, serverCommunication:ServerCommunication=null) : void {
        saveCalled = true;
    }

}
}