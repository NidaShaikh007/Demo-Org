trigger NetSuiteQuoteTrigger on Quote (after insert,after update) {
    
    For(Quote q : Trigger.New){
        
   if( !NSSyncCommanUtility.avoidRecurssion &&
   !System.isFuture() && !System.isBatch()){
                NSSyncCommanUtility.newSyncDataWithNetSuite(trigger.new, 'Quote');
        } 
   }
}

       /*    For(Quote quo : Trigger.New){
   //Quote sync DML is not dependent on trigger context however operation(Quote sync)is ASYNC.
         If(quo.IsSyncing==TRUE && 
             !System.isFuture() && 
             !System.isBatch()){
             If(Trigger.isAfter && (
         Trigger.isInsert ||
         Trigger.isUpdate)){
            NSSyncCommanUtility.newSyncDataWithNetSuite(trigger.new, 'Quote');
            System.debug('Syncing '+ quo.IsSyncing);
            System.debug('===Quote Updated===');            
        } 
      }

}

}*/