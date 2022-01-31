public class CustomCardWithSearchBarCtrl {
    
    @AuraEnabled
    public static list<contact> retriveContact()
    {
        list<contact> contactList=[SELECT  Name,
                                           Phone,
                                           Title,
                                           AccountId,
                                   		   MailingStreet,
                                   		   Mailingcity,
                                   		   Mailingstate
                                   		
                                     FROM contact];
        
        return contactList;
        
    }

}