trigger InvoicePDFAttachTrigger on Invoice__c (after insert) {
for (Invoice__c inv : Trigger.new) {
        String invId = inv.Id; 
        String description = (String)inv.Description__c;
        if(!description.equals('') && description != null){
            system.debug('invId'+invId);
            NSAttachInvoiceAsPDFCustObj.attachInvoice(invId);
        }
    }
    }