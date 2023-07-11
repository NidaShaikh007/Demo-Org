@isTest
public class TestMaketheCheckboxUnused {
    static testMethod void MaketheCheckboxUnused_Testmethod() {
        Order_Line_Item_Serials__c oli = new Order_Line_Item_Serials__c();
        
        insert oli;
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        sn.Status__c = true;
       // sn.Id = o.Id;
        insert sn;
        
        Test.startTest();
        List<Serial_Number__c> Olis = [Select Id, Serial_Number__c, Status__c from Serial_Number__c where
                                       Status__c = TRUE AND Id=: oli.Id];
        delete Olis;
        sn.Status__c = false;      
        Test.stopTest();
        
        
        //  List<Id> orderitemlist = New List<Id>();
        /* For(Order_Line_Item_Serials__c oli : Trigger.Old){
orderitemlist.add(oli.Serial_Number__c);
}*/
        /*  List<sObject> snumlist = [Select Id, Name,Serial_Number__c,  
Product__r.Id,Status__c
From Serial_Number__c Where
Status__c = TRUE AND
ID IN : orderitemlist];*/
        
        
        /*  if(snumlist.size() == 0) {
snumlist.add(new Order_Line_Item_Serials__c());
} */
        
    }
}