trigger ContactDescription on Contact (after insert, after update, after delete)
{ // perform the first action if the contact is inserted
    if(trigger.isafter && trigger.isinsert)
    {
        // creating a set variable to store the accounts id of the looped contacts
        set<id> conAccId=new set<id>();
        //as we are just inserting new contacts only loop the new contacts
        for(contact newcon: trigger.new)
        {
            //get the account id of the looped contacts
            conAccId.add(newcon.AccountId);
        }
        List<Account> accountsToBeUpdated = new List<Account>();
        // now query the list of accounts with related contacts 
        list<account> accCon= [select id, avgAge__c, (select id, age__c from contacts where age__c!=null) from account where id in :conAccId];
        
        // now loop the accounts
        for(account acc: accCon)
        {   // create a variable to store sum of age's of the contacts assciated with the accounts
            integer totalConAge=0;
            
            // now loop the contacts assciated with account
            for(contact c: acc.contacts)
            {
                // as we got all the necessary details write the logic for calculating avg age
                // the formulae for calculating average age is totalconAge =totalconAge+ c.age
                totalConAge= totalConAge+Integer.valueof(c.age__c);
            }
            acc.avgAge__c=totalConAge/acc.contacts.size();
            accountsToBeUpdated.add(acc);
        }
        
        
        
        if(accountsToBeUpdated.size()>0)
        {
            UPDATE accountsToBeUpdated;
        }
        
        
        
        
        
        
        
        
        
    }
    // perform the update trigger action whenever the contact is updated
    if(trigger.isafter && trigger.isUpdate)
    { // create a  variable to store a set of id
        set<id> conAccId=new set<id>();
        // new contacts are getting looped
        for(contact newCon : trigger.new)
        {
            //old contacts are getting looped
            for( contact oldCon: trigger.old)
            {
                // coompare the ids of old contacts and new contacts if the id's are not same the store the new contacts account id
                if(newCon.id==oldCon.id)
                {// compare the old contact age and new contact age , if they are not same then store new acc id value 
                    if(newCon.age__c!=oldCon.age__c)
                        //storing the id's in variable that has been created
                        conAccId.add(newCon.AccountId);
                }
            }
        }
        
        // store the list of accounts with assciated contacts
        // list of account shld get stored in a variable 
        list<account> updatedAccList=new list<account>();
        list<account> ExaccCon =[select id, avgAge__c, (select id, age__c from contacts where age__c!=null) from account where id in :conAccId];
        
        // loop the accounts 
        for( account acc: ExaccCon)
        {    // create a variable to store the sum of age
            integer totalAge=0;
            // loop the contacts associated with accounts
            for( contact con: acc.contacts)
            {
                if(con.age__c!=null)
                    totalAge= totalAge+integer.valueof(con.age__c);
            }
            acc.avgAge__c=totalAge/acc.contacts.size();
            updatedAccList.add(acc);
        }
        if(updatedAccList.size()>0)
        {
            update updatedAccList;
        }
        
    }
    // perform the delete trigger action whenever the contact is deleted
    if(trigger.isafter && trigger.isdelete)
    {
        
        
        // creating a set variable to store the accounts id of the looped contacts
        set<id> conAccId=new set<id>();
        //as we are just inserting new contacts only loop the new contacts
        for(contact newcon: trigger.old)
        {
            //get the account id of the looped contacts
            conAccId.add(newcon.AccountId);
        }
        List<Account> accountsToBeUpdated = new List<Account>();
        // now query the list of accounts with related contacts 
        list<account> accCon= [select id, avgAge__c, (select id, age__c from contacts where age__c!=null) from account where id in :conAccId];
        
        // now loop the accounts
        for(account acc: accCon)
        {   // create a variable to store sum of age's of the contacts assciated with the accounts
            integer totalConAge=0;
            
            // now loop the contacts assciated with account
            for(contact c: acc.contacts)
            {
                // as we got all the necessary details write the logic for calculating avg age
                // the formulae for calculating average age is totalconAge =totalconAge+ c.age
                totalConAge= totalConAge+Integer.valueof(c.age__c);
            }
            acc.avgAge__c=totalConAge/acc.contacts.size();
            accountsToBeUpdated.add(acc);
        }
        
        
        
        if(accountsToBeUpdated.size()>0)
        {
            UPDATE accountsToBeUpdated;
        }
        
        
    }
}