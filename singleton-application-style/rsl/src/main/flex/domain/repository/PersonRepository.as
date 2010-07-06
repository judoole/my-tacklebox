package domain.repository {
import application.ServerCommunication;

import domain.Person;

public interface PersonRepository {
    function save(person:Person, successFunction:Function=null, faultFunction:Function=null, serverCommunication:ServerCommunication=null) : void;
}
}