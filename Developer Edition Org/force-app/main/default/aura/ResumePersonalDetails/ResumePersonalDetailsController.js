({
	doInit : function(component, event, helper) 
    {
        
		var action = component.get("c.RetriveUserDetails");
        action.setCallback(this, function(response)
        {
            
        	var state = response.getState(); 
            if(state == "SUCCESS")
            {
                component.set("v.usr",response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action);
        
	}
})