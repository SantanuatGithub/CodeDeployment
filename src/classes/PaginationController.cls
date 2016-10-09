/****************************************************************************************************************
* @Class          : PaginationController                                                                         *
* @Description:   : Contoller of PAgination page. Responsible for showing Account records by pagination mechanism.*
* @Created By     : Cognizant                                                                  *
* @Last Modified By  :                                                                                          *   
****************************************************************************************************************/


public with sharing class PaginationController {

    public List<WrapperClass> wrapperClassList{get;set;}
    
    private List<Account> accountList = new List<Account>();
    private static final Integer PAGE_SIZE = 5;
    
    
    /*********************************
       Variable Declaration
    **********************************/    
    
    //pagination information
    public Integer numberofpages{get;set;}
    public Integer totalAcctRecords{get;set;}
    public Integer totalPages{get;set;}
    public Integer startIndex{get;set;}
    public Integer endIndex{get;set;}
    
    
    WrapperClass wrapperClassObj;
    
    /********************************************************************************
    * Constructor     : PaginationController 
    * RETURNS         : N/A
    * PARAMETERS      : ApexPages.StandardController
    * DEV TEAM        : Cognizant
    ***********************************************************************************/
    
    public PaginationController(ApexPages.StandardController controller) {
    
    wrapperClassList = new List<WrapperClass>();
    numberofpages  = 1;
    
    getAccounts();
    
       
    }
    
    /********************************************************************************
    * Method Name     : doNext
    * RETURNS         : Void
    * PARAMETERS      : N/A
    * PURPOSE         : calling to get account information for next page.
    * DEV TEAM         : Cognizant
    ***********************************************************************************/
    
    public void doNext(){
        
        if(getHasNext()){
            numberofpages++;
            getAccounts();
        }
 
    }
    
    
     /********************************************************************************
    * Method Name     : doPrevious
    * RETURNS         : Void
    * PARAMETERS      : N/A
    * PURPOSE         : calling to get account information for previous page.
    * DEV TEAM        : Cognizant
    ***********************************************************************************/
    
    public void doPrevious(){
        
        if(getHasPrevious()){
            numberofpages--;
            getAccounts();
        }
                
    }
    
    
    
    public Boolean getHasPrevious(){
        if(numberofpages>1){
            return true;
        }
        else{
            return false;
        }
    }
    
    public Boolean getHasNext(){
        if(numberofpages<totalPages){
            return true;
        }
        else{
            return false;
        }
    }
    
    
     /********************************************************************************
    * Method Name     : getAccounts
    * RETURNS         : Void
    * PARAMETERS      : N/A
    * PURPOSE         : calling to get account information.
    * DEV TEAM        : Cognizant
    ***********************************************************************************/
    
    
    
    public void getAccounts()
    {
        
        startIndex = (numberofpages-1)*PAGE_SIZE;
        endIndex = numberofpages*PAGE_SIZE;
        totalAcctRecords = 0;
        wrapperClassList.clear();
        
        
        for(Account acctObj : [Select Id,
                                      Name,
                                      Active__c,
                                      SLA__c,
                                      Ownership
                                      from Account])
        {
            if(totalAcctRecords >= startIndex && totalAcctRecords < endIndex)
            {
                wrapperClassList.add(new WrapperClass(acctObj,false));
            }
            totalAcctRecords++;
             
        }
        
       
        Decimal pages = Decimal.valueOf(this.totalAcctRecords);
        pages = pages.divide(Decimal.valueOf(PAGE_SIZE), 2);
        totalPages = (Integer)pages.round(System.RoundingMode.CEILING);
        
        
        startIndex++;
        
        
       
        if(endIndex>totalAcctRecords){
            endIndex = totalAcctRecords;
        }
     
        
        //Resource Usage Information
        System.Debug(LoggingLevel.WARN,'****** LIMIT query rows: '+Limits.getQueryRows()+' / '+Limits.getLimitQueryRows());
        System.Debug(LoggingLevel.WARN,'****** LIMIT heap size: '+Limits.getHeapSize()+' / '+Limits.getLimitHeapSize());
        System.Debug(LoggingLevel.WARN,'****** LIMIT cpu time: '+Limits.getCpuTime()+' / '+Limits.getLimitCpuTime());
        
        
    }
    
     
     /********************************************************************************
    * Method Name     : selectedRecords
    * RETURNS         : Pagereference
    * PARAMETERS      : N/A
    * PURPOSE         : query account information.
    * DEV TEAM        : Cognizant
    ***********************************************************************************/
    
    public PageReference selectedRecords()
    {
        
        Account acctObj;
        
        for(WrapperClass wrapperClassObj : wrapperClassList)
        {
           //if(wrapperClassObj.isSelection == true)
            {
                /*acctObj = new Account();
                acctObj.Name = wrapperClassObj.acctObj.Name;
                acctObj.Active__c = wrapperClassObj.acctObj.Active__c;
                acctObj.SLA__c = wrapperClassObj.acctObj.SLA__c;
                acctObj.Ownership = wrapperClassObj.acctObj.Ownership;
                accountList.add(acctObj);*/
                //wrapperClassList.add(new WrapperClass(wrapperClassObj,wrapperClassObj.isSelection));
            }
        }
        System.debug('accountList---------------->'+accountList);
        //Now you can any DML operation on Account object with accountList
        return null;
    }
    
    
    
   
     /********************************************************************************
    * Inner/Wrapper Class  : selectedRecords
    * RETURNS         : Pagereference
    * PARAMETERS      : N/A
    * DEV TEAM        : Cognizant
    ***********************************************************************************/
    
    public class WrapperClass
    {
       public Boolean isSelection{get;set;}
       public Account acctObj{get;set;}
       
       public WrapperClass(Account acct, Boolean isSelection)
       {
           this.acctObj = acct;
           this.isSelection = isSelection;
       }
    }

}