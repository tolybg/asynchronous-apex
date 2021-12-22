public with sharing class ContactUtils {

    public static Map<Id,Contact> getContactsMap(List<Id> contactIds) 
    {
        return new Map<Id,Contact>([SELECT Id FROM Contact WHERE Id IN : contactIds]);
    }

    public static List<Id> getIdsFromCollection(List<Contact> contacts)
    {
        List<Id> resultingIds = new List<Id>();

        Map<Id, Contact> tempMap = new Map<Id, Contact>(contacts);

        resultingIds = new List<Id>(tempMap.keySet());

        return resultingIds;
    }

    //
    public static List<Contact> setLeadSource(List<Contact> incomingContacts, String leadSource)
    {
        List<Contact> updatedContacts = new List<Contact>();

        for (Contact inContact : incomingContacts) 
        {
            inContact.LeadSource = leadSource;
            updatedContacts.add(inContact);
        }
        
        return updatedContacts;
    }

    //builds from Id
    public static List<Contact> setLeadSourceForContactId(List<Id> contactIds, String leadSource)
    {
        List<Contact> updatedContacts = new List<Contact>();

        for (Id thisId : contactIds) 
        {
            updatedContacts.add(new Contact( Id = thisId, LeadSource = leadSource));
        }
        
        return updatedContacts;
    }
}
