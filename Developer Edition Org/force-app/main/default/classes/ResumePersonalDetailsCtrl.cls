public class ResumePersonalDetailsCtrl 
{
    @AuraEnabled

    public static User RetriveUserDetails()
    {
        User usrdetails = [ SELECT FirstName, 
                           		   LastName, 
                                   Email, 
                                   Phone,
                                   WorkAuthorization__c 
                           from    User 
                           where FirstName='Vaishnavi'];
        
        return usrdetails;
        
        
      
        
    }
    
    
}