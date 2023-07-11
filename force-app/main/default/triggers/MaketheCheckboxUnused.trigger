trigger MaketheCheckboxUnused on Order_Line_Item_Serials__c (after delete) {
     //Serial_Number__c 
    List<Serial_Number__c> snumlist = New List<Serial_Number__c>();
    List<Id> orderitemlist = New List<Id>();
    For(Order_Line_Item_Serials__c oli : Trigger.Old){
        orderitemlist.add(oli.Serial_Number__c);
    }
    List<Serial_Number__c> Olis = 
        [Select Id, Name,Serial_Number__c,  
         Product__r.Id,Status__c
         From Serial_Number__c Where
         Status__c = TRUE AND
         ID IN : orderitemlist];
    
    For(Order_Line_Item_Serials__c orim : Trigger.Old){
        For(Serial_Number__c olisn : Olis){
            If(Trigger.IsDelete){
                olisn.Status__c = FALSE;
                snumlist.add(olisn);
            }
        }
    }
    update snumlist; 

}