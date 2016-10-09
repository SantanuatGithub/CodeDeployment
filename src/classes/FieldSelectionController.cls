public class FieldSelectionController{
	
	Map<String,Schema.SObjectType> gd;
	Map<String,String> fieldAPILabelMap = new Map<String,String>();
	
	public FieldSelectionController(){
		gd = Schema.getGlobalDescribe(); // Organization MetaData(Only Object Name) Details
	}
	
	/*public Component.Apex.OutputPanel makingDynamicUI(){
		Schema.SObjectType sobjType = gd.get('Account');  // what is sobjecttype
		Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); // MetaData details for respective sobject
		Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); // All fields api name for the same sobject
        for(String fieldName: fieldsMap.keySet())
        {
            fieldAPILabelMap.put(fieldName, fieldsMap.get(fieldName).getDescribe().getLabel());
        }
        
        String strQuery = 'SELECT Id,Field_API_Name__c,Referred_Label__c,Object_Name__c,GroupId__c,Tab_Index__c,Tab_Sequence__c,UI_Based_Validation__c FROM UI_Control__c WHERE ';
        	   strQuery += 'Object_Name__c = \
	}*/
}