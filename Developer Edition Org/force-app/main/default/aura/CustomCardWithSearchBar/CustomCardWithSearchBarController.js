({
	handleFocus : function(component, event, helper) 
    {
		
	},
    handleBlur : function(component, event, helper)
    {
        
        
    },
    doInit : function(component, event, helper)
    {
        //make a call to the controller to retrive the contact data
        var action = component.get("c.retriveContact");
        action.setCallback(this, function(response){
            
        	var state = response.getState(); 
            if(state == "SUCCESS")
            {
                component.set("v.conList",response.getReturnValue());
                
            }
            
        });
        
        $A.enqueueAction(action); 
        
    },
    handleClick : function (cmp, event, helper) {
        var buttonstate = cmp.get('v.buttonstate');
        cmp.set('v.buttonstate', !buttonstate);
    }
})