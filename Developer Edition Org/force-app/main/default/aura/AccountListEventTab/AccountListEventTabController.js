({
	doInit : function(component, event, helper) 
    {
		var action = component.get("c.retriveAllAccounts");
        action.setCallback(this, function(response){
            
        	var state = response.getState(); 
            if(state == "SUCCESS")
            {
                component.set("v.AllAccList",response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action);
	},
    handleClick : function(component, event, helper)
    {
        
        var clickedAccId = event.getSource().get("v.name");
        
        
		var appEvent = $A.get("e.c:AllAccountsToAccountDetail");
        appEvent.setParams({
            "accId":clickedAccId
        });
        appEvent.fire();
        console.log('acoount id for the button is '+clickedAccId);
        
    }
})