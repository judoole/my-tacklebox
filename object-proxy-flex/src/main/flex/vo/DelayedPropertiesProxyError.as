package vo {
public class DelayedPropertiesProxyError extends Error {
    public function DelayedPropertiesProxyError(name:*) {
        super("Variabel " + name + " does not exist on original object");
    }
}
}