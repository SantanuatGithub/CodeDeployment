public with sharing class ContactTriggerClass {
	public ContactTriggerClass() {
		
	}

	public void beforeInsertCall(List<Contact> contactList){
			for(Contact conObj : contactList){
				if(conObj.LastName == 'Test Contact')
					conObj.Title = 'Con Title';
			}
		System.debug('contactList------->'+contactList);
	}

	public void beforeUpdateCall(List<Contact> contactList){
			for(Contact conObj : contactList){
				if(conObj.LastName == 'Test Contact')
					conObj.Title = 'Con Title-UPADTED';
			}
		System.debug('contactList------->'+contactList);
	}


	public void beforeInsertCallonOLD(List<Contact> contactList){
			/*for(Contact conObj : contactList){
				if(conObj.LastName == 'Test Contact')
					conObj.Title = 'Con Title-OLD';
			}*/ //Trigger.old is read only, you can not  modify the record 
		System.debug('contactListOLD------->'+contactList);
	}

	public void beforeInsertCalltoMap(Map<Id,Contact> contactMap){
			
		System.debug('contactMap------->'+contactMap);
	}// Before Insert record has no id, so trigger.newMap returns null at before insert
	

	public void beforeUpdateCalltoMap(Map<Id,Contact> contactMap){
			
		System.debug('contactMap------->'+contactMap);
	}// Trigger.newMap is working


}