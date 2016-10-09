/** 
    Name: BoxIntegrationController 
    Developed By: Cognizant
    Purpose: To integrate between Salesforce and BOX to transfer files from Salesforce
    CreatedDate: 16th June, 2016
    Last Modified Date:
    
**/

public with sharing class BoxIntegrationController {

    public Boolean showSpinner { get; set; }
    public Boolean showUploadFileInfo{ get; set; }
    public Boolean showAgreementbtn{get;set;}

    public String queryString {get;set;}
    public String folderID {get;set;}
    
    private string authCode;
    private string accessToken; 
    private string refreshToken;
    private final string redirectURI = 'https://onlinetraining-dev-ed--c.ap1.visual.force.com/apex/BoxIntegrationPage'; 
    
    private String clientID;
    private String clientSecret;
    
    
    
   /* Constructor */
   
    public BoxIntegrationController(){
        
        showSpinner = false;
        showUploadFileInfo = false;
        showAgreementbtn = true;
        
        List<BOX_Client__c> boxClientInfoList = BOX_Client__c.getall().values();
         
         if(boxClientInfoList.size()>0){
             
             for(BOX_Client__c boxClientObj : boxClientInfoList){
                 if(boxClientObj.Name == 'BOX'){
                     clientID = boxClientObj.Client_ID__c;
                     clientSecret = boxClientObj.Client_Secret__c;
                 }
                 
             }
             
         }
         
        
        authCode = System.currentPageReference().getParameters().get('code');
        
        if(authCode <> NULL){
            getBoxToken();
            showUploadFileInfo = true;
            showAgreementbtn = false;
        }
            
       
    }
    
    /** This method is responsible to upload files from Salesforce to BOX **/
    
    public void uploadFiles(){
    
           if(accessToken <> NULL && refreshToken <> NULL){
           showSpinner = true;
           List<Attachment> attachList = [SELECT Id,
                                          Name, 
                                          ContentType, 
                                          BodyLength, 
                                          Body, 
                                          Description
                                          FROM Attachment 
                                          where Description =: queryString];
           
                                                 
           BoxApiConnection api = new BoxApiConnection(clientID, clientSecret, accessToken, refreshToken);
           BoxFolder folder = new BoxFolder(api,folderID);
           
           if(attachList.size()>0){
               for(Attachment attachObj : attachList){
                   BoxFile.Info fileInfo = folder.uploadFile(attachObj, attachObj.name);
               }
               showSpinner = false;
               
           }
           
       }
    }
    
  /** This method is responsible to generate the authentication code **/
    
    public pageReference boxauthCode(){ 
    
         PageReference pr = new PageReference('https://www.box.com/api/oauth2/authorize?' + 'response_type=code' + '&client_id=' + clientID+ '&redirect_uri=' + redirectURI); 
         return pr; 
     }
    
    
   /** This method is responsible to generate HTTPRequest and HTTPResponse **/
    
    private void getBoxToken(){
    
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = 'https://www.box.com/api/oauth2/token'; 
        req.setEndpoint(endPointValue);    
        req.setBody('Content-Type=' + EncodingUtil.urlEncode('application/x-www-form-urlencoded', 'UTF-8') + '&charset=' + EncodingUtil.urlEncode('UTF-8', 'UTF-8') + '&grant_type=' + EncodingUtil.urlEncode('authorization_code', 'UTF-8') + '&code=' + EncodingUtil.urlEncode(authCode, 'UTF-8') + '&client_id=' + EncodingUtil.urlEncode(clientID, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8') + '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8')); 
        req.setMethod('POST'); 
        HttpResponse res = h.send(req);
        
        parseAuthJSON(res.getBody()); 
        
    }
    
    
    
    private void getNewAccesstoken(){
    
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = 'https://www.box.com/api/oauth2/token'; 
        req.setEndpoint(endPointValue);    
        req.setBody('Content-Type=' + EncodingUtil.urlEncode('application/x-www-form-urlencoded', 'UTF-8') + '&charset=' + EncodingUtil.urlEncode('UTF-8', 'UTF-8') + '&grant_type=' + EncodingUtil.urlEncode('refresh_token', 'UTF-8') + '&client_id=' + EncodingUtil.urlEncode(clientID, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8') + '&refresh_token=' + EncodingUtil.urlEncode(refreshToken, 'UTF-8')); 
        req.setMethod('POST'); 
        HttpResponse res = h.send(req);
        
        parseAuthJSON(res.getBody()); 
        
    }
    
    /** This method is responsible to parse the access token and refresh token **/
    
    private void parseAuthJSON(string JSONValue){ 
        JSONParser parser = JSON.createParser(JSONValue); 
        accessToken = ''; 
        refreshToken = ''; 
        while (parser.nextToken() != null) { 
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME){ 
                if(parser.getText() == 'access_token'){ 
                    parser.nextToken(); 
                    accessToken = parser.getText(); 
                } 
                if(parser.getText() == 'refresh_token'){ 
                    parser.nextToken(); 
                    refreshToken = parser.getText(); 
                } 
            } 
            if(accessToken != '' && refreshToken != ''){ 
                break; 
            } 
       } 
    } 
}