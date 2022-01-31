global class EmailPublisherLoader implements QuickAction.QuickActionDefaultsHandler {
    // Empty constructor
    global EmailPublisherLoader() {
    }
    
    // The main interface method
    global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        
        system.debug('in email publisher defaults');
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = null;
    	
    
        // Check if the quick action is the standard case feed Send Email action
        for (Integer j = 0; j < defaults.size(); j++) {
            system.debug('SObject Type is '+defaults.get(j).getTargetSObject().getSObjectType());
            system.debug('Action Name '+defaults.get(j).getActionName());
            system.debug('Action Type is '+defaults.get(j).getActionType());
            if (defaults.get(j) instanceof QuickAction.SendEmailQuickActionDefaults && 
               defaults.get(j).getTargetSObject().getSObjectType() == EmailMessage.sObjectType && defaults.get(j).getActionName().equals('Case.SendEmail') && 
               defaults.get(j).getActionType().equals('SendEmail')) {
                   sendEmailDefaults = 
                       (QuickAction.SendEmailQuickActionDefaults)defaults.get(j);
                   break;
            }
        }
        
        if (sendEmailDefaults != null) {
            Case c = [SELECT Status, Reason FROM Case 
                      WHERE Id=:sendEmailDefaults.getContextId()];
        
            EmailMessage emailMessage = (EmailMessage)sendEmailDefaults.getTargetSObject();    
            // Set BCC address to make sure each email goes for audit
            emailMessage.BccAddress = getBccAddress(c.Reason);
            emailMessage.toAddress = 'pinky@gmail.com';
            emailMessage.htmlbody ='<html><br/><br/><br/><br/><br/><br/><br/>Thanks,<br/>Shiva</html>';
            sendEmailDefaults.setTemplateId('00X6g000000mHP3EAM');
            /*
            if (sendEmailDefaults.getInReplyToId() == null) {
                Integer emailCount = [SELECT count() FROM EmailMessage 
                                      WHERE ParentId=:sendEmailDefaults.getContextId()];
                if (emailCount!= null && emailCount > 0) {
                    sendEmailDefaults.setTemplateId(
                        getTemplateIdHelper('Automatic_Response'));
                } else {
                    sendEmailDefaults.setTemplateId(
                        getTemplateIdHelper('New_Case_Created'));
                }
                sendEmailDefaults.setInsertTemplateBody(false);
                sendEmailDefaults.setIgnoreTemplateSubject(false);
            } else {
                sendEmailDefaults.setTemplateId(
                    getTemplateIdHelper('Default_reply_template'));
                sendEmailDefaults.setInsertTemplateBody(false);
                sendEmailDefaults.setIgnoreTemplateSubject(true);
            }
*/
        }

    }
    
    private Id getTemplateIdHelper(String templateApiName) {
        Id templateId = null;
        try {
            templateId = [select id, name from EmailTemplate 
                          where developername = : templateApiName].id;   
        } catch (Exception e) {
            system.debug('Unble to locate EmailTemplate using name: ' + 
                templateApiName + ' refer to Setup | Communications Templates ' 
                    + templateApiName);
        }
        return templateId;
    }
private String getBccAddress(String reason) {
        if (reason != null && reason.equals('Technical')) 
            { return 'support_technical@mycompany.com'; } 
        else if (reason != null && reason.equals('Billing')) 
            { return 'support_billing@mycompany.com'; } 
        else { return 'support@mycompany.com'; }
    }

    
}