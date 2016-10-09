public with sharing class CustomTaskCoontroller {

    public CustomTaskCoontroller(ApexPages.StandardController controller) {

    }
    
    public pagereference onLoad()
    {
        return new PageReference('https://onlinetraining-dev-ed.my.salesforce.com/ui/core/activity/ActivityReminderPage?at=1461007801220');
    }

}