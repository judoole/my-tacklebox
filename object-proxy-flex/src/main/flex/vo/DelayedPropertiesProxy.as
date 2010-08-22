package vo {
import flash.utils.Dictionary;
import flash.utils.flash_proxy;

import mx.utils.ObjectProxy;

import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.DictionaryUtils;
import org.as3commons.lang.ObjectUtils;
import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Type;

use namespace flash_proxy;

[Bindable]
public dynamic class DelayedPropertiesProxy extends ObjectProxy {
    public var originalObjekt:Object;
    private var propertyHolder:Dictionary = new Dictionary();
    private var proxyPropertiesHolder:Dictionary = new Dictionary();
    private var originalClass:Type;

    public function DelayedPropertiesProxy(object:*) {
        super(object);
        this.originalObjekt = object;
        originalClass = Type.forInstance(object);

        try {
            for each(var accessor:Accessor in Type.forInstance(originalObjekt).accessors) {
                if (accessor.isWriteable()) {
                    var value:* = accessor.getValue(originalObjekt);

                    if (value != null && !ObjectUtils.isSimple(value))  addProxyProperty(accessor.name, value);
                }
            }
        } catch(e:Error) {
            throw(new DelayedPropertiesProxyError("Could not instantiate " + object + "\n" + e.getStackTrace()));
        }
    }

    private function addProxyProperty(name:*, value:*):void {
        proxyPropertiesHolder[name] = new DelayedPropertiesProxy(value);
    }

    flash_proxy override function getProperty(name:*):* {
        var arr:Array = DictionaryUtils.getKeys(proxyPropertiesHolder);
        if (DictionaryUtils.containsKey(propertyHolder, name.localName)) {
            return propertyHolder[name.localName];
        }
        else if (DictionaryUtils.containsKey(proxyPropertiesHolder, name.localName)) {
            return proxyPropertiesHolder[name.localName];
        }
        else return super.getProperty(name.localName);
    }

    public function updateOriginalObject():void {
        for each(var key:* in DictionaryUtils.getKeys(propertyHolder)) {
            super.setProperty(key, propertyHolder[key]);
        }
        for each(var key2:* in DictionaryUtils.getKeys(proxyPropertiesHolder)) {
            var value:* = proxyPropertiesHolder[key2];
            if (value != null) {
                var proxy:DelayedPropertiesProxy = DelayedPropertiesProxy(value);
                proxy.updateOriginalObject();
                super.setProperty(key2, proxy.originalObjekt);
            }
        }
    }

    flash_proxy override function setProperty(name:*, value:*):void {
        trace("Setter property "+name.localName);
        if(originalClass.getField(name.localName) == null) throw new DelayedPropertiesProxy(name);
        if (value == null || ObjectUtils.isSimple(value)) {
            propertyHolder[name.localName] = value;
            if (proxyPropertiesHolder[name.localName] != null) proxyPropertiesHolder[name.localName] = null;
        }
        else {
            proxyPropertiesHolder[name.localName] = new DelayedPropertiesProxy(value);
        }

        /* if (dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE)) {
         if (name is QName)
         name = QName(name).localName;
         var event:PropertyChangeEvent =
         PropertyChangeEvent.createUpdateEvent(
         this, name.toString(), getProperty(name), value);
         dispatcher.dispatchEvent(event);
         }*/
    }
}
}