@isTest
public class BugEmailTester {
static testMethod void myTestMethod() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.subject = 'FW: Broker_Dealer: Defect# 1388 - Advisor - Available Applications Search Function - When Text is entered in Search Text box - the list of Available Applications go away and do not display - IE 8';
        env.fromAddress = 'ctalbot@salesforce.com';
        email.fromAddress = env.fromAddress;
        
        BugCreator bugtestobj = new BugCreator();
        bugtestobj.handleInboundEmail(email, env);
    }
}