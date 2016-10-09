global class ExecuteCustomLabel implements Database.Batchable<sObject>
{
     
    private String referredLabel;

    public ExecuteCustomLabel (String rfdLabel) {
        referredLabel = rfdLabel;
    }
    
    global Database.Querylocator start (Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    
    global void execute (Database.BatchableContext BC, List<sobject> scope) {
    
        System.debug(' --- Entry ---');
        Component.Apex.OutputText helpTextLbl;
        helpTextLbl = new Component.Apex.OutputText();
        helpTextLbl.expressions.value = '{!$Label.' + referredLabel  + '}';
        String lblVal = String.valueOf(helpTextLbl.value);
        System.debug('labelVal---------->'+lblVal);
   }
   
  
  global void finish(Database.BatchableContext BC){
  
  }
}