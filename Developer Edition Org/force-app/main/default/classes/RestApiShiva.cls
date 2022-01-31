public class RestApiShiva 
{
	private static final String clientId = '3MVG9zlTNB8o8BA3HuH8tFrDrD6KdsiSFq6LbN_dL_RKAb3lzeflmBgbCmYihN5WGvvrY1YYETWzTTWmM8hjE';
    public static final String clientSecret = 'FEEB4A1796C6684FB512BE8344F03750D32004408D8E21083E58894AE14F0101';
    public static final String username = 'shiva.pochamalla@lightning.com';
    public static final String password = 'PinkyChinna3KoNrh0w7qaGztZWiPzc5lupZ'; 
    
    public static string getSessionId()
    {
        String reqbody ='grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        http h = new http();
        httprequest req= new httprequest();
        req.setbody(reqbody);
        req.setmethod('POST');
        req.setendpoint('https://shivaslightningplayground-dev-ed.my.salesforce.com/services/oauth2/token');
        httpresponse res= h.send(req);
        system.debug('the response is '+res.getBody());
        
        RestApiShiva.resAccessToken at=(RestApiShiva.resAccessToken)json.deserialize(res.getbody(), RestApiShiva.resAccessToken.class);
        return at.access_token;
    
    }
    
    public class resAccessToken
    {
        public string access_token;
    }
    @AuraEnabled
    public static list<accountRecord> AccountNames()
    {
        system.debug('Account names method called');
        string acctoken= getSessionId();
        
        string endpoint='https://shivaslightningplayground-dev-ed.my.salesforce.com/services/data/v20.0/query/?q=SELECT+name+from+Account+limit+3';
        httprequest req= new httprequest();
        req.setmethod('GET');
        req.setendpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+acctoken);
        http h = new http();
        httpresponse res= h.send(req);
        system.debug('the response is'+res.getBody());
        list<account> acclist= new list<account>();
       
        RestApiShiva.accountResponse ar= (RestApiShiva.accountResponse)json.deserialize(res.getBody(), RestApiShiva.accountResponse.class);
        for(accountRecord arec: ar.records){
            system.debug('response data is '+arec.Name);
        }
        
        return ar.records;
    }
    
    //wrapper classes
    public class accountResponse
    {
        public integer totalSize;
        public boolean done;
        @AuraEnabled public list<accountRecord> records{get;set;}
    }
    public class accountRecord
    {
        @AuraEnabled public string Name{get;set;}
    }
    
}