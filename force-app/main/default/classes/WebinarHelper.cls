public with sharing class WebinarHelper {
    public static void scoreAccount (Map<Id, Webinar_attendance__c> newMap) {
        Set<Id> customerIds = new Set<Id>();
        Set<Id> webinarIds = new Set<Id>();
        for (Webinar_attendance__c webAtt : newMap.values()) {
            customerIds.add(webAtt.Customer__c);
            webinarIds.add(webAtt.Webinar__c);
        }

        List<Account> accounts = [SELECT Score__c FROM Account WHERE Id IN : customerIds];

        Map<Id, Account> accountById = new Map<Id, Account>();
        for (Account acc : accounts){
            accountById.put(acc.Id, acc);
        }

        List<Webinar__c> webinars = [SELECT Webinar_Type__c FROM Webinar__c WHERE Id IN : webinarIds];

        Map<Id, Webinar__c> webinarById = new Map<Id, Webinar__c>();
        for (Webinar__c web : webinars){
            webinarById.put(web.Id, web);
        }

        for (Webinar_attendance__c webAtt : newMap.values()) {
            Account account = accountById.get(webAtt.Customer__c);
            Webinar__c webinar = webinarById.get(webAtt.Webinar__c);
            if(webinar.Webinar_Type__c == 'Personal') {
                account.Score__c = account.Score__c + 10;
            } else {
                account.Score__c = account.Score__c + 5;
            }
        }
        update accounts;
    }

    public static void scoreAccountAfterUpdate (Map<Id, Webinar_attendance__c> newMap, Map<Id, Webinar_attendance__c> oldMap){
        Set<Id> customerIds = new Set<Id>();
        //Set<Id> oldCustomerIds = new Set<Id>();
        Set<Id> webinarIds = new Set<Id>();
        for (Webinar_attendance__c webAtt : newMap.values()) {
            Webinar_attendance__c oldWebAtt = oldMap.get(webAtt.Id);
            if(webAtt.Webinar__c != oldWebAtt.Webinar__c) {
                customerIds.add(webAtt.Customer__c);
                //oldCustomerIds.add(oldWebAtt.Customer__c);
                webinarIds.add(webAtt.Webinar__c);
            }
        }
        system.debug('customerIds ' + customerIds);
        //system.debug('oldCustomerIds ' + oldCustomerIds);
        system.debug('webinarIds ' + webinarIds);

        List<Account> accounts = [SELECT Score__c FROM Account WHERE Id IN : customerIds];

        Map<Id, Account> accountById = new Map<Id, Account>();
        for (Account acc : accounts){
            accountById.put(acc.Id, acc);
        }
        system.debug('accountById ' + accountById);

        // List<Account> oldAccounts = [SELECT Score__c FROM Account WHERE Id IN : oldCustomerIds];

        // Map<Id, Account> oldAccountById = new Map<Id, Account>();
        // for (Account acc : oldAccounts){
        //     oldAccountById.put(acc.Id, acc);
        // }
        // system.debug('oldAccountById ' + oldAccountById);

        List<Webinar__c> webinars = [SELECT Webinar_Type__c FROM Webinar__c WHERE Id IN : webinarIds];

        Map<Id, Webinar__c> webinarById = new Map<Id, Webinar__c>();
        for (Webinar__c web : webinars){
            webinarById.put(web.Id, web);
        }
        system.debug('webinarById ' + webinarById);

        for (Webinar_attendance__c webAtt : newMap.values()) {
            Account account = accountById.get(webAtt.Customer__c);
            system.debug('account  ' + account);
            // Account oldAccount = oldAccountById.get(webAtt.Customer__c);
            // system.debug('account  ' + oldAccount);
            Webinar__c webinar = webinarById.get(webAtt.Webinar__c);
            system.debug('webinar  ' + webinar);
            if(webinar.Webinar_Type__c == 'Personal') {
                system.debug('Webinar_Type__c  ' + webinar.Webinar_Type__c);
                account.Score__c = account.Score__c - 5 + 10;
                system.debug('score' + account.Score__c);
            } else {
                account.Score__c = account.Score__c - 10 + 5;
            }
        }
        update accounts;
    }
    
    public static void scoreAccountAfterDelete (Map<Id, Webinar_attendance__c> oldMap){
        system.debug('oldMap ' + oldMap);
        Set<Id> customerIds = new Set<Id>();
        Set<Id> webinarIds = new Set<Id>();
        for (Webinar_attendance__c webAtt : oldMap.values()) {
            customerIds.add(webAtt.Customer__c);
            webinarIds.add(webAtt.Webinar__c);
        }
        system.debug('customerIds ' + customerIds);
        system.debug('webinarIds ' + webinarIds);

        List<Account> accounts = [SELECT Score__c FROM Account WHERE Id IN : customerIds];

        Map<Id, Account> accountById = new Map<Id, Account>();
        for (Account acc : accounts){
            accountById.put(acc.Id, acc);
        }
        system.debug('accountById ' + accountById);

        List<Webinar__c> webinars = [SELECT Webinar_Type__c FROM Webinar__c WHERE Id IN : webinarIds];

        Map<Id, Webinar__c> webinarById = new Map<Id, Webinar__c>();
        for (Webinar__c web : webinars){
            webinarById.put(web.Id, web);
        }
        system.debug('webinarById ' + webinarById);

        for (Webinar_attendance__c webAtt : oldMap.values()) {
            Account account = accountById.get(webAtt.Customer__c);
            system.debug('account  ' + account);
            Webinar__c webinar = webinarById.get(webAtt.Webinar__c);
            system.debug('webinar  ' + webinar);
            if(webinar.Webinar_Type__c == 'Personal') {
                system.debug('Webinar_Type__c  ' + webinar.Webinar_Type__c);
                account.Score__c = account.Score__c - 10;
                system.debug('score' + account.Score__c);
            } else {
                account.Score__c = account.Score__c - 5;
            }
        }
        update accounts;
    }
}