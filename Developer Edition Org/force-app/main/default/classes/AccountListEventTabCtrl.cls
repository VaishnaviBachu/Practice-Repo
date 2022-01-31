public class AccountListEventTabCtrl{
    @AuraEnabled
    public static list<account> retriveAllAccounts()
    {
        
        return [select id,name,phone from account];
        
        
    }
        
        

}