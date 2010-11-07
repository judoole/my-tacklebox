package inspirado.application {
import flash.utils.Dictionary;

import inspirado.application.error.ApplicationContextError;

import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.DictionaryUtils;
import org.as3commons.lang.ObjectUtils;
import org.as3commons.lang.StringUtils;

public dynamic class ApplicationContext {
    internal static var objects:Dictionary = new Dictionary();

    public static function addObject(object:*, id:String = null):void {
        var clazz:Class = ClassUtils.forInstance(object);
        addReferenceIdFromId(id, object);
        addReferenceIdsFromImplementations(clazz, object);
        addReferenceIdFromSuperclass(clazz, object);
        addReferenceIdFromClassname(object);
    }

    private static function addReferenceIdFromId(id:String, object:*):void {
        if (StringUtils.isNotEmpty(id)) instertObject(id, object);
    }

    private static function addReferenceIdsFromImplementations(clazz:Class, object:*):void {
        var implementedInterfaces:Array = ClassUtils.getFullyQualifiedImplementedInterfaceNames(clazz, true);
        if (!(implementedInterfaces == null || implementedInterfaces.length == 0)) {
            for each(var objectId:String in implementedInterfaces) {
                instertObject(objectId, object);
            }
        }
    }

    private static function addReferenceIdFromSuperclass(clazz:Class, object:*):void {
        var superclass:String = ClassUtils.getFullyQualifiedSuperClassName(clazz, true);
        if (superclass != ClassUtils.getFullyQualifiedName(Object, true)) {
            instertObject(superclass, object);
        }
    }

    private static function addReferenceIdFromClassname(object:*):void {
        instertObject(ObjectUtils.getFullyQualifiedClassName(object, true), object);
    }

    private static function instertObject(id:String, object:*):void {
        if (DictionaryUtils.containsKey(objects, id)) objects[id] = new ApplicationContextError("An object with the id/class " + id + "  has more than 1 single reference.")
        else objects[id] = object;
    }

    public static function getObjectById(id:String):* {
        if (objects[id] == null) throw new ApplicationContextError("Could not find object with id " + id);
        else if (objects[id] is ApplicationContextError) throw objects[id];
        else return objects[id];
    }

    public static function getObjectByType(clazz:Class):* {
        var fullyQualifiedName:String = ClassUtils.getFullyQualifiedName(clazz, true);
        return getObjectById(fullyQualifiedName);
    }
}
}
