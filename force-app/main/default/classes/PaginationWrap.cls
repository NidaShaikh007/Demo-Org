public class PaginationWrap { 

    public Boolean checked {get;set;} 
    public Account act {get;set;}
    public Decimal quantity {get;set;}
    public PaginationWrap(Account a){
        act = a;
        checked = false; 
        quantity = 0;
    }
}