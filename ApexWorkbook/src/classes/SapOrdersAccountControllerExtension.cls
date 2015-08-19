public class SapOrdersAccountControllerExtension {
    private final Account acct;
    List<SalesOrder__x> orderList;
    
    public sapOrdersAccountControllerExtension(ApexPages.StandardController stdController) {
        Account a = (Account)stdController.getRecord();
        List<Account> res = [SELECT Id, AccountNumber FROM Account WHERE Id = :a.Id LIMIT 1];
        this.acct = res.get(0);
    }
    
    public String getSapCustomerId() {
        return acct.AccountNumber;
    }
    
    public List<SalesOrder__x> getOrderList() {
        if (null == this.orderList) {
            orderList = [SELECT ExternalId, Note__c, Currency__c, NetSum__c, TotalSum__c FROM SalesOrder__x WHERE BusinessPartnerID__c = :this.acct.AccountNumber];
        }
        return orderList;
    }
}