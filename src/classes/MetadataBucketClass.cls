public with sharing class MetadataBucketClass{

    public MetadataBucketClass(){
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get('Account'); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
        System.debug('describeResult ---------->'+describeResult);
        System.debug('fieldsMap---------->'+fieldsMap);
    }
}