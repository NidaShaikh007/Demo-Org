global class NSAttachInvoiceAsPDFCustObj {
    @future (callout=true)
    
        WebService static void attachInvoice(String invoiceId) {
            System.debug('Invoice Method, invoiceId'+invoiceId);
            String pdfContent = '';
            String fileName = '';
            try
            {
                Invoice__c invoice = [select Description__c,Invoice_Number__c,Type__c,Id From Invoice__c where Id =:invoiceId];
 
      //          pdfContent = pdfContent + '<Right><H2>INVOICE</H2></Right>';
      //          pdfContent = pdfContent + '<p>Invoice #: '+oppty.get('Invoice_number__c')+'</p>';                
      //          pdfContent = pdfContent + '<p>Invoice Date: '+oppty.get('Invoice_Date__c')+'</p>';                
      //          pdfContent = pdfContent + '<p>Invoice End Date: '+oppty.get('Invoice_End_Date__c')+'</p>';                
      //          pdfContent = pdfContent + '<p>Invoice Amount: '+oppty.get('Amount__c')+'</p>';                
                                                                
                pdfContent = (String)invoice.get('Description__c');
                DateTime dt = system.now();
                String myDate = dt.format('yyyy-MM-dd HH:mm:ss', 'PST');

                fileName = (String)invoice.get('Invoice_Number__c') +'-['+ myDate+']';
                attachPDF(invoice, pdfContent, fileName);
                System.debug('attachPDF(oppty,pdfContent)');
                invoice.Description__c='';
                update invoice;

            }catch(Exception e) {
                pdfContent = '<P>THERE WAS AN ERROR GENERATING INVOICE ' + e.getMessage() + '</P>';
            }
    }
    
    public static void attachPDF(Invoice__c invoice, String pdfContent, String fileName)
    {
        try
        {
            System.debug('called attachInvoice Method');

            Attachment attachmentPDF = new Attachment();
            attachmentPDF.parentId = invoice.Id;
            attachmentPDF.Name = fileName + '.pdf';
            attachmentPDF.body = Blob.toPDF(pdfContent); //This creates the PDF content
                insert attachmentPDF;
            System.debug('insert attachmentPDF;');

        }catch(Exception e)
        {
            invoice.addError(e.getMessage());
        }
    }
}