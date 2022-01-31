public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(string ln)
    {
        List<List<sObject>> searchList = [FIND :ln IN ALL FIELDS 
                                          RETURNING Lead(FirstName,LastName),
                                          Contact(FirstName,LastName)];
        return searchList;
    }

}