public with sharing class Sample { 
 
    public List<AccountWrapper> accountWrapperList {get; set;}
     
    public Sample (){
        if(accountWrapperList == null) {
            accountWrapperList = new List<AccountWrapper>();
            for(Account a: [SELECT Id, Name From Account Limit 10]) {
                accountWrapperList.add(new AccountWrapper(a));
            }
        }
    }
      
    public class AccountWrapper {
        public Account acc {get; set;}
        public Boolean isSelected{get; set;}
  
        public AccountWrapper(Account a) {
            acc = a;
            isSelected = false;
        }
    }  
     
}