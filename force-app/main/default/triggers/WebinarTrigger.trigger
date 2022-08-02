trigger WebinarTrigger on Webinar_attendance__c (after insert, after update, after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            WebinarTriggerHandler.handleAfterInsert(Trigger.newMap);
        }

        if(Trigger.isUpdate){
            WebinarTriggerHandler.handleAfterUpdate(Trigger.newMap, Trigger.oldMap);
        }
        
        if(Trigger.isDelete){
            WebinarTriggerHandler.handleAfterDelete(Trigger.oldMap);
        }
    } 
}
