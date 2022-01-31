public class AccountHandler {
    public static account insertNewAccount(string acname)
    {
        account acct = new account(name=acname);
        try{
            
            insert acct;
           
           }
        catch(DmlException e) 
        {
    			System.debug('A DML exception has occurred: ' +
                e.getMessage ());
             return null;
        }
	 return acct;
}
}