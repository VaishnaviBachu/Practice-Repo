public class StringArrayTest {
    public static list<string> generateStringArray(integer n) 
    {
        
        string[] t= new list<string>();
        integer i;
        for(i=0;i<n;i++)
        {
            
            t.add('Test '+ i);
            system.debug(t[i]);
            
            
            
        }
        
        return t;
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}