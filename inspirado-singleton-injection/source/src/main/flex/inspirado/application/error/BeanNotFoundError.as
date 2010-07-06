package inspirado.application.error {
public class BeanNotFoundError extends Error {
    public function BeanNotFoundError(beanId:String) {
        super("Could not find bean with id '" + beanId + "'");
    }
}
}