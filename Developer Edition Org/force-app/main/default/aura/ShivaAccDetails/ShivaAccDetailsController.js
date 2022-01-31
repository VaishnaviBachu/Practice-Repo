({
	doInit : function(component, event, helper) 
    {
        //make sure the record Id is passed to JS controller
        console.log('Record id is '+component.get("v.recordId"));
		// make a call to apex controller
		helper.initialization(component, event);
		
	},
    
    handleClick : function (component, event, helper) 
    {
        var action=component.get("c.sendAccDetailsToShiva");
        action.setParams({"accountId": component.get("v.recordId")});
        action.setCallback(this, function(response){
            console.log('response state is '+response.getState());
            console.log('the response is '+response.getReturnValue());
            if(response.getState()=='SUCCESS'){
                console.log('the response is '+response.getReturnValue());
                if(response.getReturnValue()=='Success'){
                    helper.initialization(component, event);
                }
            }
        });
        $A.enqueueAction(action);
    }
})