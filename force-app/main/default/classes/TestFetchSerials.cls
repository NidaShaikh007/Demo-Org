@isTest
public class TestFetchSerials {
/*    
    @isTest static void FetchSerialsClassUnitTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        Boolean selected;
        String prodname='Test';
        OrderItem oi =new OrderItem();
        oi.Quantity= 1;
        Boolean status;
        String location = 'Pune';
        String binNo= '2';
        insert sn;
      //  List<fetchserials.wrapperfetch> w;
      //  fetchserials.wrapperfetch testFetch = new fetchserials.wrapperfetch(sn);     
      //  fetchserials fetch = new fetchserials();
    }
     @isTest  static void cancelTest(){
        fetchserials fetchcancel = new fetchserials();
           PageReference c= Page.FetchSerialsPage;
            fetchcancel.cancel();
    }
    
    @isTest  static void refreshTest(){
         Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        insert sn;
        fetchserials fetchrefresh = new fetchserials();
           PageReference c= Page.FetchSerialsPage;
            fetchrefresh.refresh();
      }
    
    
    @isTest  static void loadserialsTest(){
    /*    Order o = new Order();
        OrderItem item =new OrderItem();
        item.Description = 'Test';
        item.UnitPrice = 2;
        item.Id = o.Id;
        insert item; */
    
/*    Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        insert sn;
        fetchserials fetch1 = new fetchserials();        
          fetch1.loadSerials();
    }
    @isTest static void searchTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        insert sn;
     //   FetchSerialsClass.wrapperfetch testFetch = new FetchSerialsClass.wrapperfetch(sn);
        fetchserials fetch2 = new fetchserials();
          string SearchValue = 'SR-2020';
          fetch2.search();
          
    }
 
     @isTest static void AddSerailNumbertoOrderTest(){ 
         fetchserials fetchcancel = new fetchserials();
         Order_Line_Item_Serials__c ordersn= new Order_Line_Item_Serials__c();
         Serial_Number__c  serials = new Serial_Number__c();
        serials.Status__c = TRUE;
        serials.Location__c = 'Pune';
        serials.Bin_Number__c = '5';
         insert serials;
       //  FetchSerialsClass.wrapperfetch st = new FetchSerialsClass.wrapperfetch(serials);

          PageReference c= Page.FetchSerialsPage;
            fetchcancel.AddSerialNumbertoOrder();
     
     }
       @isTest  static void initTest(){}
      
       @isTest  static void firstTest(){
        fetchserials fetchfirst = new fetchserials();
           PageReference c= Page.FetchSerialsPage;
            fetchfirst.first();
       }
      
       @isTest  static void lastTest(){
       fetchserials fetchlast = new fetchserials();
           PageReference c= Page.FetchSerialsPage;
            fetchlast.last();
       }
      
      @isTest  static void previousTest(){
        fetchserials fetch = new fetchserials();
        Boolean test1 = fetch.hasPrevious;
        test1 = true;
      }
    
    @isTest static void nextTest(){
        fetchserials fetch = new fetchserials();
        Boolean test1 = fetch.hasNext;
        test1 = true;
    }
    
@isTest static void pageNumberTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        insert sn;
        fetchserials fetch = new fetchserials();
        Integer i = fetch.PageNumber;
     // fetch.pageNumber();
    }    
    @isTest static void getTotalPagesTest(){
        Decimal totalSize = 8;
        Decimal pageSize = 2;
        Decimal pages = 8/2 ;
        fetchserials fetch = new fetchserials();
        fetch.getTotalPages();
    }
      
       @isTest  static void getalphaSearchTest(){
        fetchserials fetchgetalphaSearch = new fetchserials();
           fetchgetalphaSearch.getalphaSearch();
       }
    
    @isTest  static void MaxNumberOfRecordsTest(){
        Serial_Number__c sn = new Serial_Number__c();
        sn.Serial_Number__c = 'SR-2020';
        insert sn;
        fetchserials fetch2 = new fetchserials();
       Integer i = fetch2.MaxNumberOfRecords;
       }
    
    @isTest  static void TotalPagesTest(){
        Integer getResultSize = 6;
        Integer getPageSize = 3;
        Integer TotalPages = 6/3;
        fetchserials fetchgetalphaSearch = new fetchserials();
        Integer total= fetchgetalphaSearch.TotalPages;
       }
           
    @isTest static void listAlphabetTest(){
        fetchserials fetchgetalphaSearch = new fetchserials();
        List<String> alphabet  =  fetchgetalphaSearch.alphabet;
      }
    
      @isTest  static void getRecordsPerPageOptionListTest(){
          list<SelectOption>  options = new list<SelectOption>();
            options.add(new selectOption('10','10'));
            options.add(new selectOption('25','25'));
            options.add(new selectOption('50','50'));
            options.add(new selectOption('100','100'));
            options.add(new selectOption('200','200'));
          fetchserials fetchrefresh = new fetchserials();
          fetchrefresh.getRecordsPerPageOptionList();
      } */
}