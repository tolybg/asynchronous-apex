public with sharing class FutureMethods 
{
    /*
    I’m intentionally giving you vague requirements. 
    You have a collection of contacts and you need to update the lead source via a future method. 
    You need to take the appropriate action to allow a future method to process those contacts as required.
    */

    /* 
     * 1. Create a future method that updates the Lead Source
     *    on a collection of Contacts. Pick any Lead Source 
    */

    public static void setLeadSource(List<Contact> contactsToUpdate, String leadSource) 
    {
        Boolean shouldRunAsync = !(System.isFuture() || System.isQueueable() || UnitTestUtils.NOT_ASYNC);

        if(shouldRunAsync)
        {
            List<Id> contactIds = ContactUtils.getIdsFromCollection(contactsToUpdate);
            setLeadSourceFuture(contactIds, leadSource);
        }
        else
        {
            List<Contact> contactList = ContactUtils.setLeadSource(contactsToUpdate, leadSource);
            update contactList;
        }

    }

    /* 
     * 3. Create a static method that queries Contacts from the database
     *    and executes the future method declared above
    */

    public static void queryContactsAndSetLeadSource(List<Id> contactIds, String newLeadSource) 
    {
        Map<Id,Contact> queriedMap = ContactUtils.getContactsMap(contactIds);

        setLeadSource(queriedMap.values(), newLeadSource);
    }

    /*
     * 4. Refactor the method from step 1 so that the processing can be 
     *    carried out in an asychronous or synchronous context. 
     *    Note that your test should continue to work without any changes
     *    Hint: You will likely want to create a ContactUtils class.
     */

    @future
    public static void setLeadSourceFuture(List<Id> contactIds, String leadSource) 
    {

        List<Contact> contactsToUpdate = ContactUtils.setLeadSourceForContactId(contactIds, leadSource);
        update contactsToUpdate;
    }
}
