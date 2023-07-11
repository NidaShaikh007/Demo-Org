@isTest
public class TestFetchSerialsClass {

    @isTest static void FetchSerialsClassUnitTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        Boolean selected;
        String prodname='Test';
        OrderItem oi =new OrderItem();
        oi.Quantity= 1;
        Boolean status;
        String location = 'Pune';
        String binNo= '2';
        insert sn;
        FetchSerialsClass fetch = new FetchSerialsClass();
        fetch.noOfRecords = 100;
        fetch.size = 5;
        fetch.total_size = 7;
        fetch.SerialList = new List<Serial_Number__c>();
        fetch.SerialList.add(sn);
        fetch.Pg_Serials = new List<Serial_Number__c>();
        fetch.Pg_Serials.add(sn);
        fetch.serialNumbers = new List<Serial_Number__c>();
        fetch.serialNumbers.add(sn);
        FetchSerialsClass.compareField = 'Serial_Number__c';
        FetchSerialsClass.sortOrder = 'ASC';
        FetchSerialsClass.wrapperfetch wrap = new FetchSerialsClass.wrapperfetch(sn,oi);
        wrap.binNo = '5';
        //wrap.compareTo(sn);
        wrap.locatn = 'Pune';
        wrap.opid = '8022w000000D0dQ';
        wrap.prodname = 'Test';
        wrap.selected = true;
        wrap.serialno = 'SR-1111';
        FetchSerialsClass.WrapperClass w = new FetchSerialsClass.WrapperClass(sn,selected);
        w.isSelected = true;
    }
    
    @isTest  static void sortWrpLstTest(){
       FetchSerialsClass fetchsort = new FetchSerialsClass(); 
        fetchsort.sortWrpLst();
    }
    
    @isTest  static void cancelTest(){        
        FetchSerialsClass fetchcancel = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetchcancel.cancel();
    }
    
    @isTest  static void refreshTest(){
        FetchSerialsClass fetchrefresh = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetchrefresh.refresh();
    }
    
    @isTest  static void loadserialsTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        insert sn;
        FetchSerialsClass fetch1 = new FetchSerialsClass();
        fetch1.loadSerials();
    }
    
    @isTest static void searchTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        insert sn;
        FetchSerialsClass fetch2 = new FetchSerialsClass();
        string SearchValue = 'SR-2021';
        fetch2.search();
    }
    
    @isTest static void AddSerailNumbertoOrderTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Order_Line_Item_Serials__c ordersn= new Order_Line_Item_Serials__c();
        Serial_Number__c  serials = new Serial_Number__c();
        serials.Status__c = TRUE;
        serials.Location__c = 'Pune';
        serials.Bin_Number__c = '5';
        insert serials;
        PageReference c= Page.FetchSerialsPage;
        fetch3.AddSerialNumbertoOrder();
    }
    
    @isTest  static void initTest(){}
    
    @isTest  static void firstTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetch3.first();
    }
    
    @isTest  static void lastTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetch3.last();
    }
    
     @isTest  static void previousTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetch3.previous();
    }
    
     @isTest  static void nextTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        PageReference c= Page.FetchSerialsPage;
        fetch3.next();
    }
    
    @isTest  static void haspreviousTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Boolean test1 = fetch3.hasPrevious;
        test1 = true;
    }
    
    @isTest static void hasnextTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Boolean test1 = fetch3.hasNext;
        test1 = true;
    }
    
    @isTest static void pageNumberTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        insert sn;
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Integer i = fetch3.PageNumber;
    }
    
    @isTest static void getTotalPagesTest(){
        Decimal totalSize = 8;
        Decimal pageSize = 2;
        Decimal pages = 8/2 ;
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        fetch3.getTotalPages();
    }
    
    @isTest  static void MaxNumberOfRecordsTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        insert sn;
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Integer i = fetch3.MaxNumberOfRecords;
    }
    
    @isTest  static void TotalPagesTest(){
       Integer getResultSize = 6;
       Integer getPageSize = 3;
       Integer TotalPages = 6/3; 
       FetchSerialsClass fetch3 = new FetchSerialsClass();
       Integer total = fetch3.TotalPages;
       System.Debug(total);

    }
    
    @isTest  static void RecordsPerPageslistTest(){
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        Integer record = fetch3.RecordsPerPageslist;
    }
    
    @isTest static void compareTo(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2021';
        Boolean selected;
        String prodname='Test';
        OrderItem oi =new OrderItem();
        oi.Quantity= 1;
        Boolean status;
        String location = 'Pune';
        String binNo= '2';
        insert sn;
        FetchSerialsClass.wrapperfetch wrap = new FetchSerialsClass.wrapperfetch(sn,oi);
      //  Integer i = wrap.compareTo(sn);
    }
  
    
    @isTest  static void getRecordsPerPageOptionListTest(){
        list<SelectOption>  options = new list<SelectOption>();
            options.add(new selectOption('10','10'));
            options.add(new selectOption('25','25'));
            options.add(new selectOption('50','50'));
            options.add(new selectOption('100','100'));
            options.add(new selectOption('200','200'));
        FetchSerialsClass fetch3 = new FetchSerialsClass();
        fetch3.getRecordsPerPageOptionList();
    }
}