@isTest
private class BoxIntegrationControllerTest{
    
    static testMethod void runBOXIntegrationTestScenario(){
        
        
        BOX_Client__c boxClientObj = new BOX_Client__c();
        boxClientObj.Name = 'BOX';
        boxClientObj.Client_ID__c = 'bp4lo3gadahjdbnslvp98cofuh3o553a';
        boxClientObj.Client_Secret__c = 'px4VlwW63UxgtuXznLWQSLgg3bbhUNuV';
        
        insert boxClientObj;
        
        Account acctObj = new Account();
        acctObj.Name = 'Test Acct';
       
        
        insert acctObj;
        
        Attachment attachObj = new Attachment();
        attachObj.Name = 'Unit Test Attachment';
        attachObj.Body =  Blob.valueOf('Unit Test Attachment Body');
        attachObj.Description = 'Test Batch';
        attachObj.parentID = acctObj.Id;
        
        insert attachObj;
        
        Test.startTest();
        
            BoxIntegrationController boxintegrationObj = new BoxIntegrationController();
            boxintegrationObj.showSpinner = false;
            boxintegrationObj.showUploadFileInfo = false;
            boxintegrationObj.showAgreementbtn = false;
            boxintegrationObj.queryString = 'Test Batch';
            boxintegrationObj.folderID = '12345';
            
            boxintegrationObj = new BoxIntegrationController();
            boxintegrationObj.uploadFiles();
            
        Test.stopTest();
        
        
    }
}