({
	initialization : function(component,event) {
		var action=component.get("c.RetriveShivaAccDetails");
        action.setParams({"accountId": component.get("v.recordId")});
        action.setCallback(this, function(response){
            console.log('response state is '+response.getState());
            if(response.getState()=='SUCCESS'){
                console.log('the response is '+response.getReturnValue());
                var resVal= JSON.parse(response.getReturnValue());
                
                component.set('v.responseval',resVal);
            }
        });
        
        $A.enqueueAction(action);
	}
})