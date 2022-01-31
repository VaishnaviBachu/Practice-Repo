public class AccountTriggerAllHandler {
	
    
    public static void handleOutOfZipContacts(List<Account> newAccounts, Map<id,Account> oldAccountsMap){
        set<id> updatedPostalCode= new set<id>();
        //1. Check for postal code change
        for(account newacc : newAccounts)
        {
            
            Account oldacc = oldAccountsMap.get(newacc.id);
            
            
            if(newacc.BillingPostalCode!=oldacc.BillingPostalCode)
            {
                updatedPostalCode.add(newacc.id);
            }
            
        }
        //3.get the postal codes of accounts with corresponding contacts postal codes
        
        Map<Id,account> ExAccConMap=new Map<Id,Account>([select id,(select id, MailingPostalCode from contacts) from account where id in :updatedPostalCode]);
        
        
        //4.compare new postal codes of accounts with postal codes of contacts associated with that accounts 
        for(account accnew: newAccounts)
        {
            account ExAccCon =ExAccConMap.get(accnew.id);
            if(ExAccCon!=null){
                for(contact c:ExAccCon.contacts)
                {
                    if(c.MailingPostalCode!=accnew.BillingPostalCode)
                    {
                        accnew.Out_of_Zip__c=true;
                        break;
                    }else
                    {
                        accnew.Out_of_Zip__c=false;
                    }
                }
            }
            
        }
        
        
    }
    
    public static void updateContactsProfile(List<Account> newAccounts, List<Account> oldAccounts){
        
        list<id> updateWebId= new list<id>();
        for(account newacc: newAccounts)
        {
            for(account oldacc:oldAccounts)
            {
                if(newacc.id==oldacc.id)
                {
                    if(oldacc.Website==null && newacc.Website!=null)
                    {
                        updateWebId.add(newacc.id);
                    }
                }
            }
            
        }
        
        list<account> exAccCon=[SELECT id, 
                                       website, 
                                       (SELECT id, 
                                       		   FirstName,
                                         	   LastName, 
                                         	   Profile__c
                                        FROM contacts) 
                                FROM account 
                                WHERE id in :updateWebId];
        List<contact> conListToUpdate = new List<Contact>();
        for(account acc: exAccCon)
        {
            for(contact c: acc.contacts)
                
            {
                if(acc.website != null){
                    String profileVal = acc.Website+'/';
                    if(String.isNotBlank(c.FirstName)){
                        profileVal= profileVal+c.FirstName;
                    }
                    profileVal = profileVal+c.LastName;
                    c.Profile__c = profileVal;
                	conListToUpdate.add(c);
                }
                    
            }
        }
        if(conListToUpdate.size()>0)
        {
            UPDATE conListToUpdate;
        }
        
        
        
    }
    
    public static void preventDuplicateAccounts(list<account> newAccounts){
        set<string> accnames= new set<string>();
        
        for(account accNew: newAccounts)
        {
            accnames.add(accNew.name);
        }
        list<account> exaccMatchedList=[select id , name from account where name in:accnames];
        
        for(account acc:exaccMatchedList)
        {
            for(account newAcc:newAccounts)
            {
                if(newAcc.Name==acc.Name)
                {
                    newAcc.adderror('Account cant be created because of duplication');
                    break;
                }
            }
            
            
        }
        
    }
    @future(callout=true) 
    public static void createSharingRuleMetadata(String name){
        MetadataService.MetadataPort service = createService();	
        MetadataService.SharingCriteriaRule sharingCriteriaRuleVar = new MetadataService.SharingCriteriaRule();
        sharingCriteriaRuleVar.fullName = 'Account.'+Name;
        sharingCriteriaRuleVar.accessLevel='Read';
        sharingCriteriaRuleVar.label=Name;
        sharingCriteriaRuleVar.booleanFilter = 'true';
        system.debug('Sharing Rule Name is '+sharingCriteriaRuleVar.fullName);
        MetadataService.SharedTo sharedToVar = new MetadataService.SharedTo();
        sharedToVar.territoryAndSubordinates = new List<String>{Name};
            sharingCriteriaRuleVar.sharedTo = sharedToVar;
        
        List<MetadataService.SaveResult> results = service.createMetadata(new MetadataService.Metadata[] { sharingCriteriaRuleVar });
        
    }
    
    @future(callout=true)
    public static void retrieveSharingRulesMetadata(){
        
        MetadataService.MetadataPort service = createService();	
        
        MetadataService.SharingRules sharingRules = (MetadataService.SharingRules) service.readMetadata('SharingRules', new String[] { 'Account' }).getRecords()[0];
		system.debug('Sharing Rules FullName is '+sharingRules.fullName);
        for(MetadataService.SharingCriteriaRule scr: sharingRules.sharingCriteriaRules){
            system.debug('Sharing Rule FullName is '+scr.fullName);
            
            for(MetadataService.FilterItem fi: scr.criteriaItems ){
                
                system.debug('Filter Items is '+fi.field);
                system.debug('Filter Items is '+fi.operation);
                system.debug('Filter Items is '+fi.value);
                fi.value = 'Testing';
            }
            
            system.debug('Shared to '+scr.sharedTo.territoryAndSubordinates );
            
        }
		
		//now add new sharingCriteriaRule and test
		
        //1. create criteria items
		MetadataService.FilterItem fi = new MetadataService.FilterItem();
        fi.field = 'Name';
        fi.operation = 'equals';
        fi.value = 'Testing2';
        
        //2. create shared to
        MetadataService.SharedTo st = new MetadataService.SharedTo();
        st.territoryAndSubordinates = new List<String>{'Current_Calendar_Year.US_East_Coast'};
        
        //3. Create account sharing settings
        MetadataService.AccountSharingRuleSettings asr = new MetadataService.AccountSharingRuleSettings();
        asr.caseAccessLevel = 'None';
        asr.contactAccessLevel = 'None';
        asr.opportunityAccessLevel = 'None';
            
        //make a new SharingCriteriaRule
        MetadataService.SharingCriteriaRule scr = new MetadataService.SharingCriteriaRule();
        scr.fullName = 'Testing2';
        scr.accessLevel = 'Read';
        scr.label = 'Testing2';
        scr.accountSettings = asr;
        scr.criteriaItems = new List<MetadataService.FilterItem>();
        scr.criteriaItems.add(fi);
        scr.sharedTo = st;
        
        //sharingRules.sharingCriteriaRules.add(scr);
        sharingRules.sharingCriteriaRules = new List<MetadataService.SharingCriteriaRule>{scr};
        
        //call update service
        MetadataService.saveResult[] resp = service.createMetadata (new MetadataService.Metadata[] { sharingRules });
        
        
    }
    
    
    public static MetadataService.MetadataPort createService()
	{ 
		MetadataService.MetadataPort service = new MetadataService.MetadataPort();
		service.SessionHeader = new MetadataService.SessionHeader_element();
		service.SessionHeader.sessionId = UserInfo.getSessionId();
		return service;		
	}
    
}