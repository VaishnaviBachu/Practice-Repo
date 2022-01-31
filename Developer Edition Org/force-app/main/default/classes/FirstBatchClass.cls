global class FirstBatchClass implements Database.Batchable<sObject>  {
    global Database.QueryLocator start(Database.BatchableContext BC)
	{

        String query = 'SELECT Description FROM Contact ';

        return Database.getQueryLocator(query);

    }
	global void execute(Database.BatchableContext BC, List<Contact> scope)

    {

        for ( Contact a : scope)

        {

           a.Description ='No description needed for the contacts';

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