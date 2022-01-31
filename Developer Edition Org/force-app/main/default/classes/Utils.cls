public class Utils {
    public static String WhoExecutedThisMethodBefore;
    public static String getObjectFromRecordId(Id recordId)
    {
        
        return recordId.getSObjectType().getDescribe().getName();
        
            
    }
    
    public static Boolean isContact(Id recordId)
    {
        WhoExecutedThisMethodBefore = 'isContact';
        String sObjName = recordId.getSObjectType().getDescribe().getName();
        if(sObjName=='Contact')
        {
            return true;
            
        }else
        {
            return false;
        }
            
    }
}