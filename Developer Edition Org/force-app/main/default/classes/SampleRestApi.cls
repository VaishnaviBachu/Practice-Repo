public class SampleRestApi {
    
    
    public static string getAllEmployees()
    {
        httprequest req = new httprequest();
        req.setmethod('GET');
        req.setEndpoint('http://dummy.restapiexample.com/api/v1/employees');
        http h= new http();
        httpresponse res= h.send(req);
        
        return res.getBody();
        
    }  
    
    public class employeesresponse
    {
        public string status;
        public list<employee> data;
        
    }    
    public class employee
    {
        public string id;
        public string employee_name;
        public string employee_salary;
        public string employee_age;
        public string profile_image;
}
    
    public static string getObjectAttributes()
    {
        httprequest req =new httprequest();
        req.setmethod('GET');
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        http h= new http();
        httpresponse res= h.send(req);
        return res.getBody();
    }
    public class sampleObj
    {
        public integer userId;
        public integer id;
        public string title;
        public boolean completed;
        
    }
    
    
}