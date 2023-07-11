trigger NetSuiteContractTrigger on Contract (after insert,after update) {
  For(Contract cont : Trigger.New){   
  //if( !NSSyncCommanUtility.avoidRecurssion){ 
  // !System.isFuture() && !System.isBatch()){
    //if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
   If(trigger.isInsert || trigger.isUpdate){
   NSSyncCommanUtility.newSyncDataWithNetSuite(trigger.new, 'Contract');
        } 
        }
        //}
      
}