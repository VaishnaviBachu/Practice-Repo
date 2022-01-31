public class ContactsMapCtrl {
    
    @AuraEnabled
    public static list<contact> retriveContacts(Id accId){
        
    	list<contact> contactlist = [select Mailingstreet, 
                                            Mailingcity, 
                                     		Mailingstate, 
                                     		Mailingcountry, 
                                      	    Mailingpostalcode,
                                     		Name,
                                     		description
                                     from Contact
                                    where accountid= :accId];
               
        
    	return  contactlist;  
    }
    
    
 
    
    

}