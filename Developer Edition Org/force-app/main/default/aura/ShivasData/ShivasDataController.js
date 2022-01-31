({
	doInit : function(component, event, helper) {
		var action= component.get("c.AccountNames");
        action.setCallback(this, function(response){
            
        	var state = response.getState(); 
            if(state == "SUCCESS")
            {
                console.log("in response success"+JSON.stringify(response.getReturnValue()));
                component.set("v.Names",response.getReturnValue());
                
            }
            
        });
        
        $A.enqueueAction(action); 
        
	}
})