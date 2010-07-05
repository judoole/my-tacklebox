package domain{
import application.DynamicApplication;
import application.ServerCommunication;

import service.PersonService;

public class Person {
    internal var service:PersonService = DynamicApplication.getService("personService") as PersonService;

    public var serverCommunication:ServerCommunication = new ServerCommunication();
    public var name:String;
    public var id:int;

    public function save() : void{
        new PersonService();
        service.save(this, update, null, this.serverCommunication);
    }

    private function update(person:Person):void {
        this.id = person.id;
    }
}
}