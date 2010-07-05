package application {
import flash.utils.Dictionary;

public interface IApplicationFacade {

    function getService(name:String):Object ;

    function addService(name:String, value:Object):void ;

    function removeService(name:String):void ;

    function getServices():Dictionary ;
}
}