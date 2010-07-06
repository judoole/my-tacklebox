package domain{
import application.DynamicApplication;
import application.IApplicationFacade;
import application.ServerCommunication;

import domain.repository.PersonRepository;

import mx.controls.Alert;

[Bindable]
public class Person {
    internal var service:PersonRepository = PersonRepository(DynamicApplication.getBeanById("personRepo"));

    public var serverCommunication:ServerCommunication = new ServerCommunication();
    public var name:String;
    public var id:int;

    public function save() : void{
        service.save(this, update, null, this.serverCommunication);
        trace(service);
    }

    private function update(person:Person):void {
        this.id = person.id;
        Alert.show("Vi fikk en person!!!! "+person.name);
    }
}
}