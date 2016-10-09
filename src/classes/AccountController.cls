public with sharing class AccountController {

     
    public Account acc;
    public AccountController(ApexPages.StandardController controller) {
        acc= (Account)controller.getRecord();
        
    }
    
    public void Save(){
        acc.Name = acc.Name+'-';
        update acc;
    }
}