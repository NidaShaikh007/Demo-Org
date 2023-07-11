trigger NetSuiteOpportunityTrigger on Opportunity (after update) {
    if(!NSSyncCommanUtility.avoidRecurssion &&
         !System.isFuture() && !System.isBatch()){
         if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
            NSSyncCommanUtility.newSyncDataWithNetSuite(trigger.new, 'Opportunity');
        } 
   }
    
}