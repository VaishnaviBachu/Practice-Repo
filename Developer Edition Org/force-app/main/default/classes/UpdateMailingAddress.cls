global  class UpdateMailingAddress implements Database.Batchable<sObject> {
 	global Database.QueryLocator start(Database.BatchableContext BC)
	{
		Id contactId='0036g00000413gMAAQ';
        String query = 'SELECT MailingStreet,MailingCity, MailingState, MailingPostalCode,MailingCountry FROM Contact where MailingPostalCode = null';

        return Database.getQueryLocator(query);

    }   
    global void execute(Database.BatchableContext BC, List<Contact> scope)

    { 
        system.debug('size is '+scope.size());
        for ( Contact a : scope)
        {
            string fulladdress = a.MailingStreet; 
            String[] address = fulladdress.split(',');
            a.MailingStreet = address[0]; 
            a.MailingCity = address[1];
            a.MailingState = address[2];
            a.MailingPostalCode = address[3];
            a.MailingCountry = address[4];
        }          
        update scope;
    } 
    
    
    global void finish(Database.BatchableContext BC)

    {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'bachuvaishnavi@gmail.com' };
        message.subject = 'Batch job completed';
        message.plainTextBody = 'Batch job completed';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }

    
    
    
    
}