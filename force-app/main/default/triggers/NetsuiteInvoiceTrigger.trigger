trigger NetsuiteInvoiceTrigger on Invoice__c(after update) {
    
    For(Invoice__c i: Trigger.New){
        if(!NSSyncCommanUtility.avoidRecurssion && 
        (!System.isFuture() && !System.isBatch())){
            System.debug('Invoice record '+ i.Id);
            NSSyncCommanUtility.newSyncDataWithNetSuite(Trigger.New,'Invoice__c');
        }
  
    }
}