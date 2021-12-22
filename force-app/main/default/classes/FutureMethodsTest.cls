@isTest
private class FutureMethodsTest 
{
    /*
     * 2. Create a method that tests the future method from the FutureMethods class 
     * Ensure that you retrieve the updated Contacts from the database
     * and assert that the Lead Source has changed
     */

     @isTest
     private static void testChangeLeadSourceFuture()
     {
        String LEAD_SOURCE_1 = 'Email';
        String LEAD_SOURCE_2 = 'Web';

        Map<Id,Contact> contactMap  = UnitTestUtils.CreateContacts(10, LEAD_SOURCE_1, null);

        Test.startTest();
        FutureMethods.setLeadSource(contactMap.values(), LEAD_SOURCE_2);

        Test.stopTest();

        for (Contact resultContact : [SELECT Id, LeadSource FROM Contact WHERE Id IN: contactMap.keySet()]) 
        {
            System.assertEquals(LEAD_SOURCE_2, resultContact.LeadSource, 'Lead Source not set!' + resultContact); // expected, actual, msg
        }
     }



     @isTest
     private static void testChangeLeadSourceNotFuture()
     {
        String LEAD_SOURCE_1 = 'Email';
        String LEAD_SOURCE_2 = 'Web';

        Map<Id,Contact> contactMap  = UnitTestUtils.CreateContacts(10, LEAD_SOURCE_1, null);

        Test.startTest();
        UnitTestUtils.NOT_ASYNC = true;

        FutureMethods.queryContactsAndSetLeadSource(ContactUtils.getIdsFromCollection(contactMap.values()), LEAD_SOURCE_2);

        Test.stopTest();

        for (Contact resultContact : [SELECT Id, LeadSource FROM Contact WHERE Id IN: contactMap.keySet()]) 
        {
            System.assertEquals(LEAD_SOURCE_2, resultContact.LeadSource, 'Lead Source not set!' + resultContact); // expected, actual, msg
        }
     }
}
