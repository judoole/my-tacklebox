package vo {

[Bindable]
public class Person {
    public var uniqueId:Number;
    public var firstname : String;
    public var lastname : String;

    public function Person(uniqueId:Number=NaN, firstname:String=null, lastname:String=null){
        this.uniqueId = uniqueId;
        this.firstname = firstname;
        this.lastname = lastname;
    }
}
}