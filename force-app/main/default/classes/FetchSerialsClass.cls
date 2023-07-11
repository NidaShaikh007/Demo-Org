Public class FetchSerialsClass{
    
    Public string OrderID {get; set;}
    Public List<OrderItem> OrderItemList {get; set;}
    Public Set<id> ProductIdSet {get; set;} //list to add product Ids
    Public list<Serial_Number__c> SerialList {get; set;}
    Public list<Serial_Number__c> SelectedSerialList {get; set;}
    Public Map<OrderItem,list<Serial_Number__c>> OrderVSerial{get; set;} // list to add OrderItem with their Serial Numbers
    Public List<wrapperfetch> fetchseriallist {get; set;}
    Public List<Order_Line_Item_Serials__c> insertordersn {get; set;} // list to add the selected orders
    Public map<id,Serial_Number__c> smap = new map<id,Serial_Number__c>();
    public List<Serial_Number__c> serialNumbers{get;set;}
    public string fullname{get; set;}
    public string finalSearchValue{get; set;}
    Public list<Serial_Number__c> Pg_Serials {get; set;} // use this list for pagination
    private integer count=1;   //to track the function calling
    private integer counter=0;   //to keep track of offset
    private integer list_size=20; //to set the page size to show the rows/records
    public integer total_size; //used to show user the total size of the list 
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public List<SelectOption> paginationSizeOptions{get;set;}    //variable used in pagination.
    public static final Integer QUERY_LIMIT = 10000;
    public static final Integer PAGE_SIZE=0;    
    public List <WrapperClass> wrapperRecordList{get;set;}
    Map<Id, WrapperClass> mapHoldingSelectedRecords{get;set;}
    public static String compareField {get; set;} 
    public static String sortOrder{get; set;}
    
    
    /*Main Class constructor and class code*/
    Public FetchSerialsClass(){
        OrderItemList = new List<OrderItem>(); // intialize
        OrderVSerial = new Map<OrderItem,List<Serial_Number__c>>();
        fetchseriallist = new List<wrapperfetch>();
        insertordersn = new List<Order_Line_Item_Serials__c>();
        SelectedSerialList = new list<Serial_Number__c>();
        SerialList = new list<Serial_Number__c>();
        OrderID = ApexPages.currentPage().getParameters().get('Id'); //Getting the id of current order
        OrderItemList=[SELECT Id,OrderId,product2Id,PricebookEntry.Product2.Name, Quantity FROM OrderItem where OrderId =:OrderID];
        loadSerials();
        mapHoldingSelectedRecords = new Map<Id, WrapperClass>();
        init();     //constructor calling init method.
        total_size=[select count() from Serial_Number__c];    //set the total size in the constructor
        RecordsPerPageslist=20;  // this is to display records per page 
    }
    public void sortWrpLst() {  
        fetchseriallist.sort();  
    }    
    Public void loadSerials(){
        ProductIdSet = new set<Id>();
        For(OrderItem items :OrderItemList){
            ProductIdSet.add(items.Product2Id);// order items products add into productidset 
        }
        SerialList = [SELECT Id,Serial_Number__c,Product_Name__c,Product__c,Name,Status__c,Bin_Number__c,Location__c
                      FROM Serial_Number__c where Status__c=FALSE And Product__c In:ProductIdSet limit 200 ];
        system.debug('Serialx' +SerialList );
        
    }
    
    Public class wrapperfetch implements Comparable{
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
        
        Public wrapperfetch(Serial_Number__c sn,OrderItem Oi)
        {  
            this.Oitem= Oi;
            this.opid =Oi.Id;
            this.prodname =sn.Product_Name__c;
            this.sno=sn;
            this.locatn=sn.Location__c;
            this.binNo=sn.Bin_Number__c;
            this.serialno = sn.Serial_Number__c;
            this.status=sn.status__c;
            this.stid=sn.id;
        }
        
        public Integer compareTo(Object compareTo){
            wrapperfetch compareToEmpl = (wrapperfetch)compareTo;
            if((String)sno.get(compareField) > (String)compareToEmpl.sno.get(compareField)){
                return sortOrder.equals('asc') ? 1 : 0;
            }
            else {
                return sortOrder.equals('asc') ? 0 : 1; 
            }
        } 
    }
    
    Public PageReference AddSerialNumbertoOrder(){
        For(OrderItem item :OrderItemList){
            For(Serial_Number__c sn :SerialList ){
                If(sn.Product__c == item.Product2Id) 
                {   SelectedSerialList = new list<Serial_Number__c>();
                 fetchseriallist.add(new wrapperfetch(sn,item)); 
                 system.debug(JSON.serializePretty(fetchseriallist));
                 SelectedSerialList.add(sn);
                 System.debug(sn);
                 System.debug(item);
                }
                else{continue;}
            }
            OrderVSerial.put(item,SelectedSerialList);
        }
        for (wrapperfetch st: fetchseriallist){
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
                smap.put(serials.id,serials);
                system.debug('smap:' +smap);
            }
        }
        if(insertordersn.size() > 0){
            insert  insertordersn;
            update smap.values();
        }
        
        pageReference pg = new pageReference('/'+OrderID);
        return pg;
    }
    /*Main code Page returning the value ends here*/
    
    /*Start search*/
    public void search(){        
        finalSearchValue = '%' + fullname + '%';
        System.debug(finalSearchValue);
        fetchseriallist = new list<wrapperfetch>();
        List<Serial_Number__c> SerialList =  [Select Id, Serial_Number__c,Product__c,Name, Product_Name__c, Status__c, Bin_Number__c, Location__c FROM Serial_Number__c
                                             where Serial_Number__c like :finalSearchValue And Status__c=FALSE And Product__c In:ProductIdSet LIMIT 200];
        System.debug(SerialList.size());
        System.debug('this is search serial list'+SerialList);
        
        
        for(OrderItem item :OrderItemList){
            for(Serial_Number__c s: SerialList){
                If(s.Product__c == item.Product2Id){
                    fetchseriallist.add(new wrapperfetch(s,item));    
                    System.debug(s);
                    System.debug(item);
                    system.debug('this is fetchserials:'+fetchseriallist);
                    
                } /*else{ 
if(SerialList.isEmpty())
System.debug('Inside null');
System.debug(finalSearchValue);
System.debug(SerialList);
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Serial Number to Search'));
}  */
            }
        }
    } 
    /*End search*/
    
    /*Start Cancel*/
    public PageReference cancel(){
        PageReference c=new PageReference('/'+OrderID);
        return c;
    }
    /*End Cancel*/
    
    /*Start Refresh*/
    
    public void  refresh(){
        /*  PageReference orderpage = new PageReference('/'+OrderID);
orderpage.setRedirect(false);
orderpage.getParameters().put('myId', OrderID);
loadSerials();
return null;*/
        
        loadSerials();
        /*  List<Serial_Number__c> serialList =  [Select Id, Serial_Number__c,Product__c,Name, Product_Name__c, Status__c, Bin_Number__c, Location__c FROM Serial_Number__c
where Status__c=FALSE And Product__c In:ProductIdSet LIMIT 200];
System.debug(serialList.size());

for(OrderItem item :OrderItemList){
for(Serial_Number__c s: serialList){
If(s.Product__c == item.Product2Id){
fetchseriallist.add(new wrapperfetch(s,item));    
System.debug(s);
System.debug(item);
} 
}
}*/
    }
    /*End Refresh*/
    
    /*Pagination code starts here*/
    /*Init method which queries the records from standard set controller*/
    public void init() {
        fetchseriallist = new List<wrapperfetch>();
        wrapperRecordList = new List<WrapperClass>();
        For(OrderItem item :OrderItemList){
            for (Serial_Number__c sno1 : (List<Serial_Number__c>)setCon.getRecords()) {
                if(sno1.Product__c == item.Product2Id && mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(sno1.id))
                {
                    //  fetchseriallist.add(mapHoldingSelectedRecords.get(sno1.id));
                    fetchseriallist.add(new wrapperfetch(sno1,item));
                }
                else{
                    fetchseriallist.add(new wrapperfetch(sno1,item));
                }
            }  }}
    
    /** Instantiate the StandardSetController from a query locater*/
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Serial_Number__c,Product_Name__c ,Name,Product__c,Status__c,Bin_Number__c,Location__c 
                                                                                       FROM Serial_Number__c where Status__c=FALSE And Product__c In:ProductIdSet ORDER BY Name limit:list_size]));
            }  /*if(RecordsPerPageslist != null){
setCon.setPageSize(RecordsPerPageslist);
} else {
setCon.setPageSize(PAGE_SIZE);
}  */ return setCon;
        }   set;    }
    
    /** indicates whether there are more records after the current page set.*/
    public Boolean hasNext { get {  return setCon.getHasNext(); }  set; }
    
    /** indicates whether there are more records before the current page set.*/
    public Boolean hasPrevious { get { return setCon.getHasPrevious(); } set;}
    
    /** returns the page number of the current page set*/
    public Integer PageNumber{ //To get current page number
        get{ this.PageNumber=setCon.getPageNumber();
            return this.PageNumber;
           } set{                                                              // To navigate to the page number entered by the user
               setCon.setPageNumber(value);       }    }
    
    /** return total number of pages for page set*/
    Public Integer getTotalPages(){
        Decimal totalSize = setCon.getResultSize();
        Decimal pageSize = setCon.getPageSize();
        Decimal pages = totalSize/pageSize;
        return (Integer)pages.round(System.RoundingMode.CEILING);
    }
    
    /** returns the first page of the page set*/
    public void first() {
        updateSearchItemsMap();
        setCon.first();
        init();    }
    
    /** returns the last page of the page set*/
    public void last() {
        updateSearchItemsMap();
        setCon.last();
        init();    }
    
    /** returns the previous page of the page set*/
    public void previous() {
        updateSearchItemsMap();
        setCon.previous();
        init();    } 
    
    /* returns the next page of the page set*/
    public void next() {
        updateSearchItemsMap();
        setCon.next();
        init();    } 
    
    /*This is the method which manages to remove the deselected records, and keep the records which are selected in map.*/
    private void updateSearchItemsMap() {
        for(WrapperClass wrp : wrapperRecordList){
            if(wrp.isSelected){
                //     fetchseriallist.add(new wrapperfetch(sno1));
                mapHoldingSelectedRecords.put(wrp.SerialRecord.id, wrp);
            } if(wrp.isSelected == false && mapHoldingSelectedRecords.containsKey(wrp.SerialRecord.id)){
                mapHoldingSelectedRecords.remove(wrp.SerialRecord.id);
            }        }    }
    
    /*wrapper class being used for checkbox showing*/
    public class WrapperClass {
        public Boolean isSelected {get;set;}
        public Serial_Number__c SerialRecord {get;set;}
        public WrapperClass(Serial_Number__c SerialRecord, Boolean isSelected) {
            this.SerialRecord = SerialRecord;
            this.isSelected = isSelected;
        }
    }
    
    /*Pagination code ends here*/
    
    /*Total number of pages as per user selection of Records per page*/
    public Integer TotalPages{                                          
        get{
            if(setCon.getResultSize() <=10)
                this.TotalPages=1;
            if(Math.Mod(setCon.getResultSize(),setCon.getPageSize()) == 0)
                this.TotalPages =(setCon.getResultSize()/setCon.getPageSize());
            else
                this.TotalPages = (setCon.getResultSize()/setCon.getPageSize()+1);
            System.Debug(this.TotalPages);
            return totalpages;
        }set;    }
    
    /*Maximum number of records in a query list*/
    public Integer MaxNumberOfRecords{                                    
        get{ return setCon.getRecords().size(); }  set;    }
    
    /*To display a drop down list on vf page*/ 
    public list<SelectOption> getRecordsPerPageOptionList(){             
        list<SelectOption>  options = new list<SelectOption>();
        options.add(new selectOption('20','20'));
        options.add(new selectOption('40','40'));
        options.add(new selectOption('80','80'));
        options.add(new selectOption('100','100'));
        options.add(new selectOption('200','200'));
        return options;
    }
    
    /*To select number of records per page*/
    public Integer RecordsPerPageslist{ 
        get;set{                                                          
            if(value!=null)
                this.RecordsPerPagesList=value; } }    
}