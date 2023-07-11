public class PassingAccountJSONtoIndividual {
//Individual

    Public void PassAccountJson(List<Account>theconcernedaccount){
        String therelatedAccount;
        List<Individual> theindividuallist = [Select Id, Name, 
                                             Company__r.Id,BirthDate,
                                             Account_JSON__c
                                             From Individual Where
                                             Company__r.Id IN :theconcernedaccount];
        List<Individual>Individuallist = New List<Individual>();
         For(Account theaccount : theconcernedaccount){
             For(Individual theindividual : [Select Id, Occupation,
                                            Name,Company__r.Id,BirthDate,
                                            Account_JSON__c From Individual Where
                                            Company__r.Id =:theaccount.Id]){
              If(theaccount.Industry!=NULL){
              theindividual.Occupation = theaccount.Industry;
              therelatedAccount = JSON.serializePretty(theaccount);
              System.debug('related Account '+therelatedAccount);
              theindividual.Account_JSON__c = therelatedAccount;
              Individuallist.add(theindividual);
              System.debug('Individual record '+theindividual.Name);
                                                    
                                                    
                                                }   
                                                
                                            }
        }
              update Individuallist;
        
    }
}