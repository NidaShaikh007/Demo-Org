@isTest
public class Test_NSAttachInvoiceAsPDFCustObj {
    Public static TestMethod void TestNSAttachInvoiceAsPDFCustObj(){
        Invoice__c invoice = New Invoice__c();
        invoice.Description__c= 'xyabzc';
        invoice.Invoice_Number__c= '123';
        invoice.Type__c= 'Invoice';
        insert invoice; 
        
        Invoice__c a = [select Description__c,Invoice_Number__c,Type__c, Id From Invoice__c where Id =:invoice.Id];
        String pdfContent = (String)a.get('Description__c');
        
        DateTime dt = system.now();
        String myDate = dt.format('yyyy-MM-dd HH:mm:ss', 'PST');

        String fileName = (String)a.get('Invoice_Number__c') +'-['+ myDate+']';
        
        attachPDF(a, pdfContent, fileName);
        
        
        update a;
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