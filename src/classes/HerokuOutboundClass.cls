public class HerokuOutboundClass{
    
    public static void getResponse(){
        soapSforceCom200509Outbound.Notification  outboundObj = new soapSforceCom200509Outbound.Notification();
        soapSforceCom200509Outbound.AccountNotification[] acctNotification;
        System.debug('OBResponse---->'+outboundObj.notifications('00D90000000xYKb','01Q90000000oQ4G','','https://www.salesforce.com/services/Soap/c/37.0','https://www.salesforce.com/services/Soap/u/37.0',acctNotification ));
    }
}