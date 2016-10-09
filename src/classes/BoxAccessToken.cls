public class BoxAccessToken{

    private final string boxClientID = 'bp4lo3gadahjdbnslvp98cofuh3o553a'; 
    private final string boxSecretCode = 'px4VlwW63UxgtuXznLWQSLgg3bbhUNuV'; 
    private final string redirectURI = 'https://onlinetraining-dev-ed--c.ap1.visual.force.com/apex/FileUploadtoBox'; 
    private final string strFolderId = '7896794177';
    private string authCode;
    private string accessToken; 
    private string refreshToken;
    
    
    
    
    public BoxAccessToken(){
        authCode = System.currentPageReference().getParameters().get('code');
        system.debug('authCode---->'+authCode);
        if(authCode <> NULL)
            getBoxToken();
            
       system.debug('accessToken---->'+accessToken);
       system.debug('refreshToken---->'+refreshToken);
       
       /*if(refreshToken <> NULL){
           getNewAccesstoken();
           system.debug('accessToken---->'+accessToken);
       }*/
       
       if(accessToken <> NULL){
           List<Attachment> attachList = [SELECT IsDeleted, Id, ParentId, Name, IsPrivate, ContentType, BodyLength, OwnerId, Body, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Description, IsPartnerShared, ConnectionReceivedId, ConnectionSentId FROM Attachment where id in('00P9000000pU2hh','00P9000000q6zvP')];
           BoxApiConnection api = new BoxApiConnection(boxClientID, boxSecretCode, accessToken, refreshToken);
           
           //BoxFolder rootFolder = BoxFolder.getRootFolder(api);
           //BoxFolder.UPLOAD_FILE_URL = 'https://upload.box.com/api/2.0/files/content?parent_id='+strFolderId;
           BoxFolder folder = new BoxFolder(api,strFolderId);
           //system.debug('rootFolder ---->'+rootFolder);
           

           for(Attachment attachObj : attachList){
               //UploadFile.uploadFileToBox('7896794177',attachobj,accessToken);
               BoxFile.Info fileInfo = folder.uploadFile(attachObj, attachObj.name);
           }
           
       }
    }
    
    
    
    public pageReference boxauthCode(){ 
         PageReference pr = new PageReference('https://www.box.com/api/oauth2/authorize?' + 'response_type=code' + '&client_id=' + boxClientID + '&redirect_uri=' + redirectURI); 
         return pr; 
         
    
    }
    
    
    private void getBoxToken(){
    
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = 'https://www.box.com/api/oauth2/token'; 
        req.setEndpoint(endPointValue);    
        req.setBody('Content-Type=' + EncodingUtil.urlEncode('application/x-www-form-urlencoded', 'UTF-8') + '&charset=' + EncodingUtil.urlEncode('UTF-8', 'UTF-8') + '&grant_type=' + EncodingUtil.urlEncode('authorization_code', 'UTF-8') + '&code=' + EncodingUtil.urlEncode(authCode, 'UTF-8') + '&client_id=' + EncodingUtil.urlEncode(boxClientID, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(boxSecretCode, 'UTF-8') + '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8')); 
        req.setMethod('POST'); 
        HttpResponse res = h.send(req);
        
        parseAuthJSON(res.getBody()); 
        if(accessToken != null & accessToken != ''){ 
            //getBoxFolder(); 
        }else{ 
            //valuetoShow = 'Get Authorization Code Return: ' + res.getBody() + ' end point value: ' + endPointValue + 'request: ' + req.toString() + 'request headers: ' + req.getHeader('Content-Type') + '; ' + req.getHeader('charset') + 'request body: ' + req.getBody(); 
        } 
    }
    
    
    
    private void getNewAccesstoken(){
    
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        string endPointValue = 'https://www.box.com/api/oauth2/token'; 
        req.setEndpoint(endPointValue);    
        req.setBody('Content-Type=' + EncodingUtil.urlEncode('application/x-www-form-urlencoded', 'UTF-8') + '&charset=' + EncodingUtil.urlEncode('UTF-8', 'UTF-8') + '&grant_type=' + EncodingUtil.urlEncode('refresh_token', 'UTF-8') + '&client_id=' + EncodingUtil.urlEncode(boxClientID, 'UTF-8') + '&client_secret=' + EncodingUtil.urlEncode(boxSecretCode, 'UTF-8') + '&refresh_token=' + EncodingUtil.urlEncode(refreshToken, 'UTF-8')); 
        req.setMethod('POST'); 
        HttpResponse res = h.send(req);
        
        parseAuthJSON(res.getBody()); 
        if(accessToken != null & accessToken != ''){ 
            //getBoxFolder(); 
        }else{ 
            //valuetoShow = 'Get Authorization Code Return: ' + res.getBody() + ' end point value: ' + endPointValue + 'request: ' + req.toString() + 'request headers: ' + req.getHeader('Content-Type') + '; ' + req.getHeader('charset') + 'request body: ' + req.getBody(); 
        } 
    }
    
    
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