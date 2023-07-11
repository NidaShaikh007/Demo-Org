trigger NetSuiteForageProgram on Forage_Program__c (after insert) {
if(!NSSyncCommanUtility.avoidRecurssion &&
         !System.isFuture() && !System.isBatch()){
         if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
            NSSyncCommanUtility.newSyncDataWithNetSuite(trigger.new, 'Forage_Program__c');
        } 
   }
}