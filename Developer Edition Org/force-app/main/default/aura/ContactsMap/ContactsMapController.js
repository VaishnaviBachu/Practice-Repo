({
	doInit : function(component, event, helper) {
		var myaccId = component.get("v.recordId");
        console.log("my account Id is "+myaccId);
        var action = component.get("c.retriveContacts");
        action.setParams({ accId : component.get("v.recordId") });

        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                //console.log("From server: " + response.getReturnValue());

                var mapmarkers=[];
                var contactlist=response.getReturnValue();
                //console.log("conList length is "+JSON.stringify(contactlist));
                for(var i=0; i<contactlist.length;i++)
                {
                    
                    var contactRec = contactlist[i];
                    
                    
                    var conLocation = {};
                    conLocation.City = contactRec.MailingCity;
                    conLocation.Street = contactRec.MailingStreet;
                    conLocation.State = contactRec.MailingState;
                    conLocation.Country = contactRec.MailingCountry;
                    conLocation.PostalCode = contactRec.MailingPostalCode;
                    
                    console.log("end");
                    
                    var marker = {};
                    marker.location = conLocation;
                    marker.title = contactRec.Name;
                    marker.description = contactRec.Description;
                    
                    mapmarkers.push(marker);
                    
                    
                    
                }
                console.log("markers length is "+mapmarkers.length);
                
                component.set("v.mapMarkers",mapmarkers);
                //display toast message on the screen
                //helper.showToast(component, "Success",'Success','The markers have been marked successfully');
            	
                //component.set("v.modalopen",true);
                
            }
            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                        helper.showToast(component, "Error",'Error Occured',errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        
        $A.enqueueAction(action);
    
	},
    closemodal : function (component, event) 
    {
        component.set("v.modalopen",false);
    }
    
})