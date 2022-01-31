public class ContctCardAndMapsWithSearchctrl {

    @AuraEnabled
    
    public static list<contact> getcontactdetails()
    {
        list<contact> contctlist = [select Name,
                                           Phone,
                                           Title,
                                           AccountId,
                                   		   MailingStreet,
                                   		   Mailingcity,
                                   		   Mailingstate,
                                    	   Id
                                   		
                                     FROM contact];
         return contctList;
        
     }
}