package inspirado.application {
import inspirado.application.error.BeanNotFoundError;

import flash.utils.Dictionary;

import flash.utils.getQualifiedClassName;

import inspirado.beans.InitializingBean;

import mx.events.FlexEvent;

import org.as3commons.lang.ClassUtils;

import spark.components.Application;

public dynamic class DynamicApplication extends Application {
    internal static var beans:Dictionary = new Dictionary();
    private static var beansToBeInitializedAfterCreationComplete:Array = new Array();

    public function DynamicApplication(){
        super();
        this.addEventListener(FlexEvent.CREATION_COMPLETE, initializeBeans)
    }

    public static function getBeanById(id:String, required:Boolean=false):Object {
        var bean:Object = beans[id];
        if(required && bean == null) throw new BeanNotFoundError(id);
        else return bean;
    }

    public static function getBeanByClass(clazz:Class, required:Boolean=false) : Object{
        throw new Error("Not implemented");
    }

    public static function addBean(id:String, value:Object):void {
        var clazz:Class = ClassUtils.forInstance(value);
        if(ClassUtils.isImplementationOf(clazz, InitializingBean)) beansToBeInitializedAfterCreationComplete.push(value);
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

    private function initializeBeans(event:FlexEvent) : void{
        for each(var bean:InitializingBean in beansToBeInitializedAfterCreationComplete){
            bean.afterCreationComplete();
        }
    }
}
}