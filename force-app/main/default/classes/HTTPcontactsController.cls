public class HTTPcontactsController {
    public HTTPcontactsController(){
        // HTTP Request Class
        HTTPRequest requestParam = new HTTPRequest();
        requestParam.setEndpoint(Label.ContactsEndpointURL);
        requestParam.setMethod('GET');
        
        // HTTP Response Class
        HTTP httpParam = new HTTP();
        HTTPResponse response = httpParam.send(requestParam);
        String strResponse = response.getBody();
        system.debug('Service Response is---->' +strResponse);
        
        
    }
    
}