({
	handleDetailView : function(component, event, helper) {
		console.log("event received"+event.getParam("accId"));
        var accountId = event.getParam("accId");
        // set the handler attributes based on event data
        component.set("v.EventSentAccId",accountId);

	}
})