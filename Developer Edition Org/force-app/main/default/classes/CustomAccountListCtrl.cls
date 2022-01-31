public class CustomAccountListCtrl {
	
    @AuraEnabled
    public static Account retrieveAccount(){
		       
        List<Account> accVarList = [SELECT Id,
                                           Name,
                                           Website,
                                           AccountNumber
                                           
                                    FROM Account];
        
        return accVarList[1];
        
        
        
    }
    
    
}