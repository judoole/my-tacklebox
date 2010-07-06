package repository {
import application.ServerCommunication;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;
import mx.rpc.Responder;
import mx.rpc.events.FaultEvent;
import mx.rpc.remoting.RemoteObject;

public class AbstractRemoteObjectRepository {
    //judoole Could this be strongly typed as RemoteObject?
    /** The Service-RemoteObject */
    public var service:RemoteObject;

    private var _faultHandler:Function = getDefaultFaultHandler();

    /** Useful to set to true when creating integrationTests. FlexUnit TestCase.addAsync expect a FlashEvent */
    public var getDataAsEvent:Boolean = false;

    /**
     * @return The faultHandler of this Facade
     */
    public function get faultHandler():Function
    {
        return _faultHandler;
    }

    /**
     * Set The faultHandler of this Facade
     * @param fault
     */
    public function set faultHandler(fault:Function):void
    {
        _faultHandler = fault;
    }

    /**
     *
     * @param token - The servicecall. Example service.save(myObject)
     * @param resultHandler - Function callback
     * @param fault - Function faultHandler
     *
     */
    protected function callServiceFunction(token:AsyncToken, resultHandler:Function, faultHandler:Function = null, serverCommunication:ServerCommunication = null):void
    {
        if(serverCommunication!=null) serverCommunication.isCommunicating = true;
        var responder:IResponder = new Responder(getResultHandler(resultHandler, serverCommunication), getFaultFunction(faultHandler, serverCommunication));
        token.addResponder(responder);
    }

    /**
     * Creates a default Function for handling faults. This implementations just traces the Error.
     *
     * @return A default Function for handling faults
     */
    protected function getDefaultFaultHandler():Function
    {
        return function(info:Object):void
        {
            var fault:FaultEvent = info as FaultEvent
            trace(fault.fault.getStackTrace());
        }
    }

    /**
     *
     * @param serverCommunication
     * @return A FaultHandlerFunction that updates the serverCommunication-object if a fault happens.
     */
    private function getFaultHandlerWithServerCommunication(serverCommunication:ServerCommunication, fault:Function):Function {
        return function(info:Object) : void{
            serverCommunication.isCommunicating = false;
            fault(info);
        }
    }

    /**
     * If the fault is null we return the default faultHandler.
     * If not, the calling component wants to override the faultHandling it self so we return the fault function parameter
     *
     * @param fault - The faultFunction from the component
     * @return A faultHandler Function
     */
    private function getFaultFunction(fault:Function, serverCommunication:ServerCommunication):Function
    {
        if (fault == null && serverCommunication == null) return _faultHandler;
        else if (serverCommunication != null) return getFaultHandlerWithServerCommunication(serverCommunication, fault == null ? _faultHandler : fault);
        else return fault;
    }

    /**
     * Function to get the result from the data on the server and put it on the resultFunction.
     *
     * @param func - The resultHandling function from the component
     * @return - A newly created function encapsulating the result of the data
     */
    private function getResultHandler(func:Function, serverCommunication:ServerCommunication):Function
    {
        if (getDataAsEvent) {
            return func;
        }
        else {
            return function(data:Object):void {
                serverCommunication.isCommunicating = false;
                func(data.result);
            }
        }

    }


}
}