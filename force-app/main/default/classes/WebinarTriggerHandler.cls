public with sharing class WebinarTriggerHandler {
    public static void handleAfterInsert(Map<Id, Webinar_attendance__c> newMap) {
        WebinarHelper.scoreAccount(newMap);
    }

    public static void handleAfterUpdate(Map<Id, Webinar_attendance__c> newMap, Map<Id, Webinar_attendance__c> oldMap) {
        WebinarHelper.scoreAccountAfterUpdate(newMap, oldMap);
    }

    public static void handleAfterDelete(Map<Id, Webinar_attendance__c> oldMap) {
        WebinarHelper.scoreAccountAfterDelete(oldMap);
    }
}