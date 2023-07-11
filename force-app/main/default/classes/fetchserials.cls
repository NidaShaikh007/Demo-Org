@TestVisible
Public class fetchserials{
  /*  
    Public string OrderID {get; set;}
    Public order OrderInstance {get; set;}
    Public List<OrderItem> OrderItemList {get; set;}
    Public Set<id> ProductIdSet {get; set;} //list to add product Ids
    Public list<Serial_Number__c> SerialList {get; set;}
    Public list<Serial_Number__c> SelectedSerialList {get; set;}
    Public Map<OrderItem,list<Serial_Number__c>> OrderVSerial{get; set;} // list to add OrderItem with their Serial Numbers
    Public List<wrapperfetch> fetchseriallist {get; set;}
    Public List<Order_Line_Item_Serials__c> insertordersn {get; set;} // list to add the selected orders
    Public map<id,Serial_Number__c> smap = new map<id,Serial_Number__c>();
    public List<Serial_Number__c> serialNumbers;
    public string fullname{get;set;}
    public string finalSearchValue{get;set;}
    Public list<Serial_Number__c> Pg_Serials {get; set;} // use this list for pagination
    private integer count=1;   //to track the function calling
    private integer counter=0;   //to keep track of offset
    private integer list_size=10; //to set the page size to show the rows/records
    public integer total_size; //used to show user the total size of the list 
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}*/
    
    
    /*Main Class constructor and class code*/
  /*  Public fetchserials(){
        OrderItemList = new List<OrderItem>(); // intialize
        OrderVSerial = new Map<OrderItem,List<Serial_Number__c>>();
        fetchseriallist = new List<wrapperfetch>();
        insertordersn = new List<Order_Line_Item_Serials__c>();
        SelectedSerialList = new list<Serial_Number__c>();
        SerialList = new list<Serial_Number__c>();
        OrderID = ApexPages.currentPage().getParameters().get('Id'); //Getting the id of current order
        //     OrderInstance = [SELECT Id FROM Order where Id=:OrderID ];
        //   OrderItemList=[SELECT Id,OrderId,product2Id,PricebookEntry.Product2.Name, Quantity FROM OrderItem where OrderId =:OrderID];
        loadSerials();
        mapHoldingSelectedRecords = new Map<Id, wrapperfetch>();
        init();
        total_size=[select count() from Serial_Number__c];    //set the total size in the constructor
        RecordsPerPageslist=10; // this is to display records per page
        
    }
    public PageReference cancel() {
        PageReference c=new PageReference('/'+OrderID);
        return c;
    }   
    
    Public void loadSerials(){
        OrderItemList=[SELECT Id,OrderId,product2Id,PricebookEntry.Product2.Name, Quantity FROM OrderItem where OrderId =:OrderID];
        ProductIdSet = new set<Id>();
        For(OrderItem items :OrderItemList){
            ProductIdSet.add(items.Product2Id);// order items products add into productidset 
        }
        SerialList = [SELECT Id,Serial_Number__c,Product_Name__c ,Name,Product__c,Status__c,Bin_Number__c,Location__c
                      FROM Serial_Number__c where Status__c=FALSE And Product__c In:ProductIdSet limit 200 ];
        system.debug('Serialx' +SerialList );
        
        For(OrderItem item :OrderItemList){
            For(Serial_Number__c sn :SerialList ){
                If( sn.Product__c == item.Product2Id) 
                {   SelectedSerialList = new list<Serial_Number__c>();
                 fetchseriallist.add(new wrapperfetch(sn));
                 SelectedSerialList.add(sn);
                }
                else{continue;}
            }
            OrderVSerial.put(item,SelectedSerialList);
        }
    }
    
    public void search(){
        finalSearchValue = '%' + fullname + '%';
        System.debug(finalSearchValue);
        fetchseriallist = new list<wrapperfetch>();
        List<Serial_Number__c> serialList =  [Select Id, Serial_Number__c, Product_Name__c, Status__c, Bin_Number__c, Location__c FROM Serial_Number__c
                                              where Serial_Number__c like :finalSearchValue];
        System.debug(serialList.size());
         for(Serial_Number__c s : serialList){
                fetchseriallist.add(new wrapperfetch(s));    
                System.debug(s);
            }
      /*  if(finalSearchValue!=NULL){
            for(Serial_Number__c s : serialList){
                fetchseriallist.add(new wrapperfetch(s));    
                System.debug(s);
            }
        }else{
            clearsearch();
        } 
    }
*/    
  /*  public void clearsearch()
    {     
        if(finalSearchValue == NULL){ 
        for (wrapperfetch cls: fetchseriallist ){
            If (cls.selected == true ){
                    for(Serial_Number__c s1 : serialList){ 
                //  fetchseriallist.remove(new wrapperfetch(s1)); 
                    fetchseriallist.add(new wrapperfetch(s1));
                        System.debug(s1);
                    }
                }
            }
        }
    }
        
        Public class wrapperfetch{
            Public Serial_Number__c sno{get; set;}
            Public Boolean selected {get; set;}
            Public string prodname {get; set;}
            Public OrderItem Oitem{get; set;}
            Public string serialno {get; set;}
            Public Boolean status {get; set;}
            Public String locatn{get;set;}
            Public String binNo{get;set;}
            Public Id stid {get; set;}
            Public Id opid {get; set;}
            
            Public wrapperfetch(Serial_Number__c sn){  
                this.prodname =sn.Product_Name__c;
                this.sno=sn;
                this.locatn=sn.Location__c;
                this.binNo=sn.Bin_Number__c;
                this.serialno = sn.Serial_Number__c;
                this.status=sn.status__c;
                this.stid=sn.id;
            }
        }
        
        Public PageReference AddSerialNumbertoOrder(){
            
            for (wrapperfetch st: fetchseriallist ){
                If (st.selected == true ){
                    Order_Line_Item_Serials__c ordersn= new Order_Line_Item_Serials__c();
                    ordersn.Serial_Number__c=st.stid;
                    ordersn.Order_Product__c=st.opid;
                    insertordersn.add(ordersn);
                    Serial_Number__c  serials = new Serial_Number__c();
                    serials.id = st.stid;
                    serials.Status__c = TRUE;
                    serials.Location__c=st.locatn;
                    serials.Bin_Number__c = st.binNo;
                    SelectedSerialList.add(serials);
                    smap.put(serials.id,serials );
                }
                
            }
            if(insertordersn.size() > 0){
                insert  insertordersn;
                update smap.values();
            }
            pageReference pg = new pageReference('/'+OrderID);
            return pg;
        }*/
        /*Main code Page returning the value ends here*/
        
        /*this code is for pagination*/
        //variable used in page.
/*        public List<SelectOption> paginationSizeOptions{get;set;}
        public static final Integer QUERY_LIMIT = 20000;
        public static final Integer PAGE_SIZE = 5;    
        public List <wrapperfetch> fetchseriallist1{get;set;}
        Map<Id, wrapperfetch> mapHoldingSelectedRecords{get;set;}
        
        //constructor calling init method. into fetch serials constructor
        /* public fetchserials(){
mapHoldingSelectedRecords = new Map<Id, wrapperfetch>();
init();
}  */
        
        //Init method which queries the records from standard set controller.
    /*    public void init() {
            fetchseriallist1 = new List<wrapperfetch>();
            for (Serial_Number__c srnum : (List<Serial_Number__c>)setCon.getRecords()) {
                if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(srnum.id)){
                    fetchseriallist1.add(mapHoldingSelectedRecords.get(srnum.id));
                    
                }
                else{
                    fetchseriallist1.add(new wrapperfetch(srnum));
                }
            }
        }
        
        /** Instantiate the StandardSetController from a query locater*/
       /* public ApexPages.StandardSetController setCon {
            get {
                if(setCon == null) {
                    setCon = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name, Id,Serial_Number__c, Product_Name__c, Status__c, Bin_Number__c, Location__c FROM Serial_Number__c LIMIT : QUERY_LIMIT ]));
                    system.debug('the page size is:' +PAGE_SIZE);
                    // sets the number of records to show in each page view
                    setCon.setPageSize(PAGE_SIZE);
                }
                return setCon;
            }
            set;
        }
        
        /** indicates whether there are more records after the current page set.*/
    /*    public Boolean hasNext {
            get {
                return setCon.getHasNext();
            }
            set;
        }
        
        /** indicates whether there are more records before the current page set.*/
    /*    public Boolean hasPrevious {
            get {
                return setCon.getHasPrevious();
            }
            set;
        }
        
        /** returns the page number of the current page set*/
 /*       public Integer pageNumber {
            get {
                return setCon.getPageNumber();
            }
            set;
        }
        
        /** return total number of pages for page set*/
  /*      Public Integer getTotalPages(){
            Decimal totalSize = setCon.getResultSize();
            Decimal pageSize = setCon.getPageSize();
            Decimal pages = totalSize/pageSize;
            return (Integer)pages.round(System.RoundingMode.CEILING);
        }
        
        /** returns the first page of the page set*/
 /*       public void first() {
            //  updateSearchItemsMap();
            setCon.first();
            init();
        }
        
        /** returns the last page of the page set*/
  /*      public void last() {
            //  updateSearchItemsMap();
            setCon.last();
            init();
        }
        
        /** returns the previous page of the page set*/
        /*    public void previous() {
// updateSearchItemsMap();
setCon.previous();
init();
} */
        
        /** returns the next page of the page set*/
        /*   public void next() {
//  updateSearchItemsMap();
setCon.next();
init();
} */
  /*      public pageReference refresh() {
            setCon = null;
            loadSerials();
            setCon.setPageNumber(1);
            return null;
        }
        
        //This is the method which manages to remove the deselected records, and keep the records which are selected in map.
        /*   private void updateSearchItemsMap() {
for(wrapperfetch wrp : fetchseriallist1){
if(wrp.status){
mapHoldingSelectedRecords.put(wrp.sn.Id, wrp);
}
if(wrp.status == false && mapHoldingSelectedRecords.containsKey(wrp.sn.Id)){
mapHoldingSelectedRecords.remove(wrp.sn.Id);
}
}
} */
        
        //wrapper class being used for checkbox showing.
        /*   public class WrapperClass {
public Boolean isSelected {get;set;}
public Serial_Number__c serialRecord {get;set;}
public WrapperClass(Serial_Number__c serialRecord, Boolean isSelected) {
this.serialRecord = serialRecord;
this.isSelected = isSelected;
}
} */
        
        /*Pagination ends here*/  
        
        
        /*This code is for Pagination with alphabetic search*/
        
  /*      public list<String> alphabet{
            get{                                                                                                                    //To display a list of alphabets on vf page 
                alphabet = new list<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Others','All'};
                    return alphabet;         
            } set;
        } /*alphaSearchConct = alphaSearchSerials //con = Pg_Serials  */
    
  //      public String alphaSearchSerials{get;set;}  // To get commandlink parameter for alphabet selected
        
    /*    public Pagereference getalphaSearch(){ //To update contact list as per the alphabet selected by the user
            
            if (alphaSearchSerials=='All'){
                Pg_Serials = [SELECT Id,Serial_Number__c,Product_Name__c ,Name,Product__c,Status__c
                              FROM Serial_Number__c where Status__c=FALSE And Product__c In:ProductIdSet];
            }
            else{
                Pg_Serials = [SELECT Id,Serial_Number__c,Product_Name__c ,Name,Product__c,Status__c
                              FROM Serial_Number__c where Serial_Number__c Like:alphaSearchSerials+'%' AND Status__c=FALSE And Product__c In:ProductIdSet limit 200 ];
                
            }
            // ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(Pg_Serials);
            // stdSetController= setCon;
            return null;
        }      
        /*public Integer PageNumber1{ 
//To get current page number
get{                                                            
this.PageNumber1=stdSetController.getPageNumber1();
return this.PageNumber1;
}
// To navigate to the page number entered by the user
set{                                                      
stdSetController.setPageNumber(value);
}
}*/
        // Total number of pages as per user selection of Records per page
     /*   public Integer TotalPages{                                          
            get{
                if(setCon.getResultSize() <=10)
                    this.TotalPages=1;
                if(Math.Mod(setCon.getResultSize() ,setCon.getPageSize()) == 0)
                    this.TotalPages =(setCon.getResultSize()/setCon.getPageSize());
                else
                    this.TotalPages = (setCon.getResultSize()/setCon.getPageSize())+1;
                System.Debug(this.TotalPages);
                return totalpages;
            }
            set;
        }
        public Integer MaxNumberOfRecords{                                    //Maximum number of records in a query list
            get{
                return setCon.getRecords().size();
            }
            set;
        }
        public list<SelectOption> getRecordsPerPageOptionList(){              //To display a drop down list on vf page  
            list<SelectOption>  options = new list<SelectOption>();
            options.add(new selectOption('10','10'));
            options.add(new selectOption('25','25'));
            options.add(new selectOption('50','50'));
            options.add(new selectOption('100','100'));
            options.add(new selectOption('200','200'));
            return options;
        }
        public Integer RecordsPerPageslist{ 
            get;set{                                                          //To select number of records per page
                System.debug(value);
                if(value!=null){
                    this.RecordsPerPagesList=value;
                }
                else
                this.RecordsPerPageslist=10;
            }       
        }
       /*alphabetic search ends here
        
*/
    }