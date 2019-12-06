trigger DDD_Event_AllTriggers on DDD_Event__e (after insert) {

    for (DDD_Event__e event : Trigger.new) {
        // @TODO - bulkify!
        AppEventManager.handleEvent(event.Type__c, event.Data__c);
    }
}