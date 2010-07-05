package application {
import flash.utils.Dictionary;

import spark.components.Application;

public class DynamicApplication extends Application {
    public function DynamicApplication() {
        super();
    }

    private static var services:Dictionary = new Dictionary();

    // Consider using getter and setter if you need to override behavior // but a workaround with "static" problem in Flex
    public static function getService(name:String):Object {
        return services[name];
    }

    public static function addService(name:String, value:Object):void {
        services[name] = value;
    }

    public static function removeService(name:String):void {
        delete services[name];
    }

    public static function getServices():Dictionary {
        return services;
    }
}
}