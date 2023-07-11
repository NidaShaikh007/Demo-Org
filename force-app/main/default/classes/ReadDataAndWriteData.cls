global class ReadDataAndWriteData implements Database.Batchable<sObject>, Schedulable, 
Database.RaisesPlatformEvents {

    private String query;
    private Date fixedDate;
    private Date oldMonth;
    private Date newMonth;
    private String oldMonthName;
    private String newMonthName;
    private String oldMonYear;
    private String newMonYear;
    private String oldmmm;
    private String newmmm;
    
    global ReadDataAndWriteData(Date dt) {
        String dateQueryFormat = String.valueOf(dt)+'T00:00:00.000Z';
        System.debug('dateQueryFormat='+dateQueryFormat);
        this.query = 'SELECT Id,Name,Budget_Confirmed__c,AccountId,ContractId,Description,LeadSource,CurrencyIsoCode,Pricebook2Id,StageName,Type,Clone_Quote__C FROM Opportunity WHERE Already_Monthly_Cloned__c=false AND accountID != null AND account.status__C = \'ACTIVE\' AND CreatedDate<'+dateQueryFormat ;
        this.fixedDate = dt;
    }
    
    global ReadDataAndWriteData() {
        this.query = 'SELECT Id,Name,Budget_Confirmed__c,AccountId,ContractId,Description,LeadSource,CurrencyIsoCode,Pricebook2Id,StageName,Type,Clone_Quote__C FROM Opportunity WHERE Already_Monthly_Cloned__c=false AND accountID != null AND account.status__C = \'ACTIVE\' AND CreatedDate<TODAY ';
        this.fixedDate = null;
    }    

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    global void execute(SchedulableContext  sc) {
        ReadDataAndWriteData oppClCon = new ReadDataAndWriteData(); 
        Database.executebatch(oppClCon,Integer.valueOf('200'));
    }
    
    global void execute(Database.BatchableContext BC, list<Sobject> scope) {
        String endpointURL = 'https://accounts.google.com/o/oauth2/v2/auth?';
        endpointURL += 'scope=https%3A//www.googleapis.com/auth/drive.metadata.readonly&';
        endpointURL += 'access_type=offline&';
        endpointURL += 'include_granted_scopes=true&';
        endpointURL += 'response_type=code&';
        endpointURL += 'state=https%3A//sfconnecterlightning-dev-ed.my.salesforce.com/&';
        endpointURL += 'redirect_uri=https%3A//oauth2.example.com/code&';
        endpointURL += 'client_id=47116427671-6irk2p1uv63fm6mied08s4eeae4m4sa8.apps.googleusercontent.com';



        HttpRequest req = new HttpRequest();
        Http http = new Http();
        String version = '2.0';
        String timestamp = String.valueOf(DateTime.now().getTime()/1000); //seconds since unix epoch
        String nonce = String.valueOf(Crypto.getRandomLong()); //random number
        
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(120000);
        req.setMethod('GET');
        req.setEndpoint(endPointUrl);
        
        try {
            HttpResponse res = http.send(req);
            System.debug('======res.getBody()===='+res.getBody());
        } catch(Exception e){
            System.debug('Error: '+ e.getMessage());
        }
        
    }
    
    private void getDateValues(Date theDate){
        oldMonth = theDate.addMonths(-1);
        newMonth = theDate; 

        oldMonthName = getMonthString(oldMonth.month());
        newMonthName = getMonthString(newMonth.month());
        oldMonYear = String.valueOf(Integer.valueOf(oldMonth.month())).leftpad(2,'0') + String.valueOf(oldMonth.year()).substring(2,4);
        newMonYear = '-' + String.valueOf(Integer.valueOf(newMonth.month())).leftpad(2,'0') + String.valueOf(newMonth.year()).substring(2,4);
        oldmmm = oldMonthName.substring(0,3);
        newmmm = newMonthName.substring(0,3);
        System.debug('oldMonth='+oldMonth);
        System.debug('newMonth='+newMonth);
    }
     public static String getMonthString(integer intmonth){
        if(intmonth == 1) return 'January';
        if(intmonth == 2) return 'February';
        if(intmonth == 3) return 'March';
        if(intmonth == 4) return 'April';
        if(intmonth == 5) return 'May';
        if(intmonth == 6) return 'June';
        if(intmonth == 7) return 'July';
        if(intmonth == 8) return 'August';
        if(intmonth == 9) return 'September';
        if(intmonth == 10) return 'October';
        if(intmonth == 11) return 'November';
        if(intmonth == 12) return 'December';
        return 'Invalid';
    }

    global void finish(Database.BatchableContext BC) {

    }
}