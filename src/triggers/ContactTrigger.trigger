trigger ContactTrigger on Contact (before insert, before update, after insert) {

    ContactTriggerClass contgrObj = new ContactTriggerClass();
    if(Trigger.isBefore && Trigger.isInsert)
    {
        contgrObj.beforeInsertCall(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isUpdate)
    {
        contgrObj.beforeUpdateCall(Trigger.new);
    }

    /*if((Trigger.isbefore || Trigger.isAfter) && Trigger.isInsert)
    {
        contgrObj.beforeInsertCallonOLD(Trigger.old);
    }*/ //It returns error message as dereference null object as Trigger.old always returns null value at before or after insert.

    if(Trigger.isbefore && Trigger.isUpdate)
    {
        contgrObj.beforeInsertCallonOLD(Trigger.old);
    }

    if(Trigger.isBefore && Trigger.isInsert)
    {
        contgrObj.beforeInsertCalltoMap(Trigger.newMap);
    } 

    if(Trigger.isBefore && Trigger.isUpdate)
    {
        contgrObj.beforeUpdateCalltoMap(Trigger.newMap);
    } 

}