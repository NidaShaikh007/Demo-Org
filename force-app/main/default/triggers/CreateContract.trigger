trigger CreateContract on Opportunity (before update) {
    For(Opportunity opp: Trigger.New){
        CreateContractonDemand ccd = New CreateContractonDemand();
        ccd.CreateContract(Trigger.New); 
    }
}