public with sharing class CustomSettingsService {
    
    //Return a record that shows whether the RecordTypeMapping feature is enabled
    public FeatureSettings__c getMapperEnablementRecord() {
        return FeatureSettings__c.getInstance();
    }

    //Update the org-level custom setting
    //Returns the original value
    public Boolean updateMapperEnablementRecord(Boolean newValue) {
        FeatureSettings__c enablementRecord = [Select Id, FeatureEnabled__c from FeatureSettings__c LIMIT 1];
        Boolean originalValue = enablementRecord.FeatureEnabled__c;

        enablementRecord.FeatureEnabled__c = newValue;
        update enablementRecord;

        return originalValue;
    }

    //Return a record that shows which record type name to use for the given countryCode
    //and industry values on a new lead.
    public RecordTypeMappingCmdt__mdt getRecordTypeMapping(String countryCode, String industry) {
        RecordTypeMappingCmdt__mdt mapping = null;

        List<RecordTypeMappingCmdt__mdt> mappings =  [SELECT Id, RecordTypeName__c FROM RecordTypeMappingCmdt__mdt 
                WHERE CountryCode__c = :countryCode AND Industry__c = :industry];
        if (mappings.size() > 0) {
            mapping = mappings.get(0);
        }
        return mapping;
    }

    
}