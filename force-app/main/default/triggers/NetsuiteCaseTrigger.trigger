trigger NetsuiteCaseTrigger on Case (after insert, after update) {
    
    For(Case c : Trigger.New){
        if(!NSSyncCommanUtility.avoidRecurssion && (!System.isFuture() && !System.isBatch()))
        {
            NSSyncCommanUtility.newSyncDataWithNetSuite(Trigger.New,'Case');
        }
  
    }
}