trigger AccountTrigger on Account (before insert,before update) {

    for(Account accObj : Trigger.new)
    {
        //if(accObj.Name == 'Web Account 3')
             //accObj.Name.addError('Web Account 3 is an invalid account');
        
        //Database.executeBatch(new ExecuteCustomLabel(accObj.site));
            
       //CustomLabelController Obj = new CustomLabelController();
       //Obj.CustomLabelController1(accObj.site);
    }

}