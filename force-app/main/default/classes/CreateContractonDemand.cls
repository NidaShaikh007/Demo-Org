public class CreateContractonDemand {
    
    public void CreateContract(List<Opportunity>oppolist){
        List<Contract>contralist = New List<Contract>();
        List<Opportunity>opplist = 
             [Select Id, Name, AccountId, Account.Industry,StageName,Create_Contract__c From 
             Opportunity Where ID IN : oppolist];
        For(Opportunity opp : opplist){
            If(opp.Create_Contract__c == TRUE){
                Contract cont = New Contract();
                cont.AccountId = opp.AccountId;
                cont.Opportunity__c = opp.Id;
                cont.Status ='Draft';
                cont.StartDate = Date.today()+15;
                cont.ContractTerm = 12;
                contralist.add(cont);
            }
        }
        insert contralist;
        
    }

}