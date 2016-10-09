public with sharing class InnerClassTableSelectionController {

    public List<WrapperClass> wrapperClassList{get;set;}
    
    private List<Account> accountList = new List<Account>();
    private List<Account> acctList;
    
    WrapperClass wrapperClassObj;
    
    public InnerClassTableSelectionController(ApexPages.StandardController controller) {
    
    acctList = new List<Account>();
    
    acctList = [Select Id,
                       Name,
                       Active__c,
                       SLA__c,
                       Ownership
                       from Account 
                       where name in ('Account1','Account2')];
   
    wrapperClassList = new List<WrapperClass>();
    
    
    if(!acctList.isEmpty() && acctList.size()>0 )
    {
        for(Account acctObj : acctList)
        {
            wrapperClassObj = new WrapperClass();
            wrapperClassObj.name = acctObj.Name;
            wrapperClassObj.active = acctObj.Active__c;
            wrapperClassObj.SLA = acctObj.SLA__c;
            wrapperClassObj.ownership = acctObj.Ownership;
            wrapperClassList.add(wrapperClassObj);
        }
    }
        
       
    }
    
    public PageReference selectedRecords()
    {
        
        Account acctObj;
        
        for(WrapperClass wrapperClassObj : wrapperClassList)
        {
            if(wrapperClassObj.isSelection == true)
            {
                acctObj = new Account();
                acctObj.Name = wrapperClassObj.name;
                acctObj.Active__c = wrapperClassObj.active;
                acctObj.SLA__c = wrapperClassObj.SLA;
                acctObj.Ownership = wrapperClassObj.ownership;
                accountList.add(acctObj);
            }
        }
        System.debug('accountList---------------->'+accountList);
        //Now you can any DML operation on Account object with accountList
        return null;
    }
    
   
    
    public class WrapperClass
    {
       public Boolean isSelection{get;set;}
       public String name{get;set;}
       public String active{get;set;}
       public String SLA{get;set;}
       public String ownership{get;set;}
    }


}