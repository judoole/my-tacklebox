package application {
import application.error.BeanNotFoundError;

import flash.utils.Dictionary;

import flash.utils.getQualifiedClassName;

import spark.components.Application;

public dynamic class DynamicApplication extends Application {
    internal static var beans:Dictionary = new Dictionary();

    public static function getBeanById(id:String, required:Boolean=false):Object {
        var bean:Object = beans[id];
        if(required && bean == null) throw new BeanNotFoundError(id);
        else return bean;
    }

    public static function getBeanByClass(clazz:Class, required:Boolean=false) : Object{
        throw new Error("Not implemented");
    }

    public static function addBean(id:String, value:Object):void {
        beans[id] = value;
    }

    public static function removeBean(id:String):void {
        delete beans[id];
    }

    public static function getAllBeans():Dictionary {
        return beans;
    }

    internal static function removeAllBeans() : void{
        for(var id:Object in beans){
            removeBean(id as String);
        }
    }
}
}