trigger OppAmount on Opportunity (after update) 
{ 
    list<id> oppUpdateId = new list<id>();
    List<Account> accList = new List<Account>();
    set<id> accIdSet = new set<id>();
    
	for(opportunity newopp : trigger.new)
    {
        
        if(newopp.amount>20000)
        {

            Account acc = new Account();
            acc.Id = newopp.AccountId;
            acc.Is_Gold__c =true;
            if(!accIdSet.contains(acc.Id)){
                accList.add(acc);
            	accIdSet.add(acc.Id);
            }
            
            
            	
            
        }
        
    }
    
    if(accList.size()>0)
    	Update accList;
 
	 
	 
    
}