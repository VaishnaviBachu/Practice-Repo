({
	doInit : function(component, event, helper) {
        
		var action = component.get("c.retrieveAccount");
        action.setCallback(this, function(response){
            
        	var state = response.getState(); 
            if(state == "SUCCESS")
            {
                component.set("v.acc",response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action);
        
	}
})