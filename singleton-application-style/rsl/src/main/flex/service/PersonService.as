package service {
import domain.Person;
import application.ServerCommunication;

public interface PersonService {
    function save(person:Person, successFunction:Function, faultFunction:Function, serverCommunication:ServerCommunication) : void;
}
}