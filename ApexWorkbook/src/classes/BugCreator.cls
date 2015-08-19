Global class BugCreator implements Messaging.inboundEmailHandler {
    Global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) {
    
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        createBug(email.subject, email.plainTextBody, env.fromAddress);
        result.success = true;
        return result;
    
    }
    
    public static Bug__c createBug(String BugDescr, String BugBody, String fromEmail) {
        List<User> finduser = [SELECT Id FROM User WHERE Email = :fromEmail];
        User founduser;
        if (finduser.size() > 0) {
            founduser = finduser[0];
        } else {
            List<User> randomuser = [SELECT Id FROM User];
            founduser = randomuser[0];
        }
    
        Bug__c newBug = new Bug__c(Title__c = BugDescr, Description__c = BugBody, Status__c = 'New', Type__c = 'Bug', Priority__c = '2 - High', Logged_By__c = foundUser.Id);
        insert newBug;
        return newBug;
    
    }
    
    


}