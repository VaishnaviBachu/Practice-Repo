public class ShivaAccDetailsCtrl 
{
    @AuraEnabled
    public static string RetriveShivaAccDetails(id accountId)
    {
        account acc=[select Name from account where id=:accountId];
        string accName=acc.Name;
        accName= accName.replace(' ','_');
        string accToken = RestApiShiva.getSessionId();
        string endpoint='https://shivaslightningplayground-dev-ed.my.salesforce.com/services/apexrest/AccountServices/'+accName;
        httprequest req= new httprequest();
        req.setMethod('GET');
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+accToken);
        http h= new http();
        httpresponse res=h.send(req);
 		system.debug('returning '+res.getBody());
        return res.getBody();
        
    }
    @AuraEnabled
    public static String sendAccDetailsToShiva(id accountId)
    {
        Account acc=[SELECT Name,
                             Phone,
                             Website,
                             BillingStreet,
                             BillingCity,
                             BillingState,
                             BillingPostalCode,
                             BillingCountry,
                     		 AccountUniqueId__c
                     FROM Account 
                     WHERE id=:accountId];
        string accString = JSON.serialize(acc);
        string accToken = RestApiShiva.getSessionId();
        
        ShivaSOAPAccountUpdate.SOAPWebServiceClass wsc = new ShivaSOAPAccountUpdate.SOAPWebServiceClass();
        ShivaSOAPAccountUpdate.SessionHeader_element headerEle = new ShivaSOAPAccountUpdate.SessionHeader_element();
        headerEle.sessionId = accToken;
        wsc.SessionHeader= headerEle;
        String shivaAccountResponse = wsc.makeAccount(accString);
        
        
        return shivaAccountResponse;
                                            
        
    }

    
}