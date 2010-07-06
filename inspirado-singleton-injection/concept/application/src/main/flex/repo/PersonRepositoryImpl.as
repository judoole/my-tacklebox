package repo {
import application.DynamicApplication;
import application.ServerCommunication;

import domain.Person;

import domain.repository.PersonRepository;

import mx.controls.Alert;
import mx.rpc.remoting.RemoteObject;
import mx.rpc.remoting.RemoteObject;

import repository.AbstractRemoteObjectRepository;

public class PersonRepositoryImpl extends AbstractRemoteObjectRepository implements PersonRepository{
    public function PersonRepositoryImpl(){
        service = RemoteObject(DynamicApplication.getBeanById("personService", true));
    }

    public function save(person:Person, callbackFunction:Function=null, faultFunction:Function=null, serverCommunication:ServerCommunication=null):void {
        callServiceFunction(service.save(person), callbackFunction, faultFunction, serverCommunication);
    }

}
}