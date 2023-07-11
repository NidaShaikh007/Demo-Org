@isTest(SeeAllData=true)
public class RHX_TEST_Order_Line_Item_Serials {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Order_Line_Item_Serials__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Order_Line_Item_Serials__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}