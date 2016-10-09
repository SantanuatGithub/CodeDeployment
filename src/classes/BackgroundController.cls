public with sharing class BackgroundController {

    public List<Account> acctList{get;set;}
    
    public BackgroundController(ApexPages.StandardController controller) {
    
    acctList = [Select Id,
                       Name,
                       Active__c,
                       SLA__c,
                       Ownership,
                       Createdby.Name,
                       LastModifiedBy.Name
                       from Account
                       where name in ('Account1','Account2')];
    }
    

}