public class CallHTTPMethods {

    public static void callLocalHost(){
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        //request.setEndpoint('https://spal12.herokuapp.com/conversion');
        request.setEndpoint('callout:MyHerokuApp/conversion');
        request.setHeader('Content-Type','application/xml');
        request.setMethod('GET');
        request.setClientCertificateName('TestSelfSigned');
    //request.setClientCertificateName('StudentScoutCertificateBase64');
        try{
            //for(integer i =0; i<15;i++){
            HTTPResponse response = http.send(request);
            string responseBody = response.getBody();
            system.debug('REST Response '+ responseBody);
            //}
        }catch(exception e){
            system.debug('An unexpected error occured: '+ e.getMessage());
        }
    }
    
    
    
}