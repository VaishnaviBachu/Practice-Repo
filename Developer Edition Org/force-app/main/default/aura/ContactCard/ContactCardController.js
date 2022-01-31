({
	doInit : function(component, event, helper)
    {
        //make a call to the controller to retrive the contact data
        
        
        var con=component.get("v.con");
        
        component.set('v.mapMarkers', [
            {
                location: {
                    Street: con.MailingStreet,
                    City: con.MailingCity,
                    State: con.MailingState
                },
                
                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
        component.set('v.zoomLevel', 8);
            
            
        
        
    }
})