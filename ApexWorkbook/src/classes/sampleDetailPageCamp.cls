public class sampleDetailPageCamp {
    private List<ActivityHistory> actv;
    private Campaign camp;
    public sampleDetailPageCamp(ApexPages.StandardController controller) {
        this.camp = (Campaign)controller.getRecord();
    }
    public List<ActivityHistory> getActv() {
        List<Campaign> c = [SELECT (SELECT ActivityDate, ActivityType, Description, CreatedBy.Name, Status, WhatId from ActivityHistories where Campaign_Info__c = :camp.id) from Campaign where id = :camp.id];
        for (ActivityHistory ah : c[0].getSObjects('ActivityHistories')) { //Campaign b: c) {
            actv.add(ah);// = [SELECT name, type from ActivityHistory where Campaign_Info__c = :camp.id];
        }
        return actv;
    }
}