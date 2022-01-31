//trigger executes on a DML operation INSERT, UPDATE and DELETE
//can create any number of triggers on an object but they won't run in order
trigger AccountTriggerAll on Account (before update, after update, before insert, after insert)
{ 	//2. Store the Account Id of the ones that changed
    if(trigger.isUpdate)
    {
        if(trigger.isbefore)
        {    
            list<Account> accNamesUpdatedAccounts= new list<Account>();
            AccountTriggerAllHandler.handleOutOfZipContacts(trigger.new,trigger.oldMap);
            
            for(account newAcc:trigger.new)
            {
                
                Account oldAcc = trigger.OldMap.get(newAcc.Id);
                if(newAcc.Name!=oldAcc.Name)
                {
                    accNamesUpdatedAccounts.add(newAcc);
                }

            
            }
            if(accNamesUpdatedAccounts.size()>0){
                AccountTriggerAllHandler.preventDuplicateAccounts(accNamesUpdatedAccounts);
                
            }
            
        }
        if(trigger.isafter)
        { 
            AccountTriggerAllHandler.updateContactsProfile(trigger.new,trigger.old);
        }		
        
    }
    
    
    if(trigger.isInsert)
    { 
        if(trigger.isBefore)
        {
        	AccountTriggerAllHandler.preventDuplicateAccounts(trigger.new);
        }
        //sharing rule code starts here
        if(trigger.isAfter){
            Account acc = trigger.new[0];
           	AccountTriggerAllHandler.retrieveSharingRulesMetadata();
			
            //handleSaveResults(results[0]);
			            
            
            

            
            
        }
        
        
        
        
    }
    
    
    
    
}