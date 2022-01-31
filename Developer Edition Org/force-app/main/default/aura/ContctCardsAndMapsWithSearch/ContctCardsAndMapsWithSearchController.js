({
    doInit : function(component, event, helper)
    { 
        //make a call to the controller to retrive the contact data
        var action = component.get("c.getcontactdetails");
        action.setCallback(this, function(response){
            
            var state = response.getState(); 
            if(state == "SUCCESS")
            {
                component.set("v.conList",response.getReturnValue());
                var conListresponse = response.getReturnValue();
                
                
                var conMarkerList = [];
                console.log('here in init');
                for(var i=0;i<conListresponse.length;i++){
                    
                    var conVar = conListresponse[i];
                    var conMarker= {};
                    
                    var marker = [{
                        location: {
                            Street: conVar.MailingStreet,
                            City: conVar.MailingCity,
                            State: conVar.MailingState
                        },
                        
                        title: conVar.Name,
                        description: 'marker desc'
                    }];
                    
                    conMarker.contactRec = conVar;
                    conMarker.contactMarker = marker;
                    conMarker.modalopen = false;
                    
                    conMarkerList.push(conMarker); 
                    //console.log(JSON.stringify(conMarker))
                }
                
                component.set("v.contactMarkerList",conMarkerList);   
            }
        });
        component.set('v.zoomLevel', 2);
        $A.enqueueAction(action); 
        
    },
    
    handleClick : function (component, event, helper) 
    {
        console.log(event.getSource().get("v.value"));
        var conMarkerList = component.get("v.contactMarkerList");
        for(var i=0;i<conMarkerList.length;i++){
            if(conMarkerList[i].contactRec.Id == event.getSource().get("v.value")){
                conMarkerList[i].modalopen = true;
                break;
            }
            
        }
        component.set("v.contactMarkerList",conMarkerList);
        //component.set("v.modalopen",true)
    },
    
    handleok : function (component, event, helper) 
    { console.log(event.getSource().get("v.name"));
      var conMarkerList = component.get("v.contactMarkerList");
      for(var i=0;i<conMarkerList.length;i++)
      {
          if(conMarkerList[i].contactRec.Id == event.getSource().get("v.name"))
          {
          conMarkerList[i].modalopen = false;
          break;
          }
      }   
        component.set("v.contactMarkerList",conMarkerList);
      //component.set("v.modalopen",false)
    },
    handlesearch: function(component, event, helper) 
    {
        var searchWord= component.get("v.searchWord");
        var conmrkList = component.get("v.contactMarkerList");
        var conmatchedList = [];
        
        for (var key in conmrkList) {
            var objCopy = conmrkList[key]; // copies each property to the objCopy object
            if(objCopy.contactRec.Name==searchWord)
            {
                
                conmatchedList.push(objCopy);
                conmatchedList.push(objCopy);
                
                
            } 
        }
        console.log(conmatchedList.length);
        component.set("v.contactMarkerList",conmatchedList);
    }
});