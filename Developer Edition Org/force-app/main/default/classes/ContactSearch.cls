public class ContactSearch {
    public static list<contact>searchForContacts(string ln, string mpc)
    {
        list<contact> con =[SELECT FirstName,LastName,id 
                          FROM Contact WHERE LastName=:ln AND MailingPostalCode=:mpc];
        return con;
        
        
    }


    
}