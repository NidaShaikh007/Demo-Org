@isTest
public class Test_CaseCreateUpdate {
    Public static TestMethod void TestUpdateCasecreate(){
        Case c = New Case();
        c.Subject= 'FinalCase';
        insert c; update c;
    }

}