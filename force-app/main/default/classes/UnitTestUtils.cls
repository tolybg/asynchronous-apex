public with sharing class UnitTestUtils 
{
    public static Boolean NOT_ASYNC = false;

    public static Map<Id,Contact> CreateContacts(Integer numberOfContacts, String leadSource, Account acc) 
    {
        List<Contact> resultContacts = new List<Contact>(CreateContacts_InMemory(numberOfContacts, leadSource, acc));
        insert resultContacts;
        return new Map<Id,Contact>(resultContacts);
    }

    public static List<Contact> CreateContacts_InMemory(Integer numberOfContacts, String leadSource, Account acc) 
    {
        List<Contact> newContacts = new List<Contact>();

        if(null == acc)
        {
            acc = CreateAccount('Test Account' + numberOfContacts);
        }

        for (Integer i = 0; i < numberOfContacts; i++) 
        {
            newContacts.add(new Contact( 
                FirstName = 'Joe' + i,
                LastName = 'Test' + i,
                AccountId = acc.Id,
                LeadSource = leadSource
            ));
        }
        return new List<Contact>(newContacts);
    }

    public static Account CreateAccount(String accName)
    {
        return new Account(Name = accName);
    }
}
