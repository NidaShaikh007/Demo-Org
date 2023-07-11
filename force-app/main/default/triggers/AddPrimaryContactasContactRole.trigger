trigger AddPrimaryContactasContactRole on Opportunity (before update) {
    
/*objective is to add Opporuntity lookup contact as Primary
opporuntiycontactrole. This way need not to add contactrole sepreately 
while sending opporuntiy JSON. */
    
List<OpportunityContactRole> opcontactrolelist = New List<OpportunityContactRole>();
    //stores only the lookup Id if exists;
List<Id>PrimaryContactId = New List<Id>();
For(Opportunity o : Trigger.New){
PrimaryContactId.add(o.Primary_Contact__c);
System.debug('Contact Id '+PrimaryContactId);
}
    
List<Contact>Primarycontact= [Select Id, 
 FirstName, LastName, Phone, Email
 From Contact Where ID IN : PrimaryContactId];
For(Opportunity opp: Trigger.New){
/*If(Trigger.NewMap.get(opp.Id).Primary_Contact__c 
!=Trigger.OldMap.get(opp.Id).Primary_Contact__c
&& opp.Primary_Contact__c !=NULL) */
For(Contact con : Primarycontact){
If(opp.Primary_Contact__c !=NULL 
&& opp.Has_Contact__c !=TRUE){
            
OpportunityContactRole   oppcontact = New OpportunityContactRole();        
oppcontact.OpportunityId = opp.Id; 
oppcontact.IsPrimary  = TRUE;
oppcontact.Role = 'Decision Maker';
oppcontact.ContactId = con.Id;
opcontactrolelist.add(oppcontact);
opp.Has_Contact__c = TRUE;
System.debug('Opporuntity has contact '+opp.Has_Contact__c);
con.Primary_Contact__c = TRUE;
con.Role__c = oppcontact.Role;
System.debug('==========================');
System.debug('Contact Role '+ con.Role__c);
}
            
}
}
   insert opcontactrolelist;
}