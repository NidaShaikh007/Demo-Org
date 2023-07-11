trigger  UpdateContactandOpportunity on OpportunityContactRole (before insert, before update) {
    
/*When ContactRole is added or updated
  Update related contact and Opportunity,
  other objective is to trigger Opprotunity json.*/
List<Contact>conlist = New List<Contact>();
List<Opportunity>opplist = New List<Opportunity>(); 
List<Id>contactId = New List<Id>();
List<Id>opportunityId = New List<Id>();
    // Sync_Opportunity__c  ,  Primary_Contact__c
    
    For(OpportunityContactRole opco : Trigger.New){
            contactId.add(opco.ContactId);
            System.debug('contactId'+contactId);
            opportunityId.add(opco.OpportunityId);
            System.debug('opportunityId'+opportunityId);
    }
    List<Contact>listofcontacts = 
            [Select Id, LastName,Primary_Contact__c From
            Contact Where ID IN :contactId];
    List<Opportunity>listofOpprtunity = 
            [Select Id, Name,Sync_Opportunity__c From
            Opportunity Where ID IN :opportunityId];
    For(OpportunityContactRole opr : Trigger.New){
        For(Contact con : listofcontacts){
            con.Role__c = opr.Role;
            For(Opportunity opp :listofOpprtunity){
            If(Trigger.IsInsert || Trigger.IsUpdate){                    
            opp.Sync_Opportunity__c = TRUE;
            
            opplist.add(opp);
            System.debug('Opportunity '+opplist);
            }
            If(opr.IsPrimary==TRUE){
            //con.Role__c = opr.Role;
            con.Primary_Contact__c = TRUE;
            
            conlist.add(con);
            System.debug('Contact '+conlist);
            }
            }
            update conlist; update opplist;
            }
    }
}