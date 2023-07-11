trigger NetsuiteOrderTrigger on Order (after update, after delete) {
    For(Order o: Trigger.New){
        if(!NSSyncCommanUtility.avoidRecurssion && 
        (!System.isFuture() && !System.isBatch())){
            System.debug('Order record '+ o.Id);
            NSSyncCommanUtility.newSyncDataWithNetSuite(Trigger.New,'Order');
        }
  
    }
    if(trigger.isDelete){
        
    }

}