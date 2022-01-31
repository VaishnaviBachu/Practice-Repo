public class FirstAPI {
    private final String clientId = '3MVG9zlTNB8o8BA3HuH8tFrDrD6KdsiSFq6LbN_dL_RKAb3lzeflmBgbCmYihN5WGvvrY1YYETWzTTWmM8hjE';
    public final String clientSecret = 'FEEB4A1796C6684FB512BE8344F03750D32004408D8E21083E58894AE14F0101';
    public final String username = 'shiva.pochamalla@lightning.com';
    public final String password = 'PinkyChinna3KoNrh0w7qaGztZWiPzc5lupZ'; 
    
    public string getSessionId(){
        
        String reqbody ='grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://shivaslightningplayground-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse res = h.send(req);
        system.debug('Access Response is '+res.getBody());
        FirstAPI.deserializeResponse dr = (FirstAPI.deserializeResponse)JSON.deserialize(res.getBody(), FirstAPI.deserializeResponse.class);
        system.debug('response is '+dr.access_token );
        return dr.access_token;
        
    }
    @AuraEnabled
    public AccountResponse getAllAccounts(){
    	

        string sessionId = getSessionId();
        
        //make a http variable
        http h = new http();
        
        //make a httpRequest variable
        HttpRequest httpRequest = new HttpRequest(); 
		httpRequest.setMethod('GET');  
		httpRequest.setHeader('Authorization', 'OAuth ' + sessionId);       
		httpRequest.setHeader('Authorization', 'Bearer ' + sessionId);
		httpRequest.setEndpoint('https://shivaslightningplayground-dev-ed.my.salesforce.com/services/data/v20.0/query/?q=Select+id,name+from+account');
        
        //create a HTTPRESPONSE variable to store the response
        HttpResponse res = h.send(httpRequest);  
        system.debug('Response is '+res.getBody());
        AccountResponse ar = (AccountResponse)JSON.deserialize(res.getBody(),AccountResponse.class);
        
        for(AccountRecords arRec: ar.records){
            system.debug('Account Id is-'+arRec.Id+' Name is-'+arRec.Name);
            
        }
        
        return ar; 
        
    }
    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    public class AccountResponse{
        public List<AccountRecords> records;
        
    }
    public class Accountrecords{
        public String Id;
        public String Name;
        
        
    }
    
}