public class UnitOfWorkImpl implements UnitOfWork {
    
    private Set<String> registeredSObjectTypes = new Set<String>();
    private Map<String, Schema.SObjectField> externalIdByType = new Map<String, Schema.SObjectField>();
    private Map<String, Map<String, SObject>> upsertMapByType = new Map<String, Map<String, SObject>>();
    private Map<String, Map<String, SObject>> deleteMapByType = new Map<String, Map<String, SObject>>();

    public class UnitOfWorkException extends Exception {}

    public UnitOfWorkImpl() {
    }

    public void registerSObjectTypes(Map<Schema.SObjectType, Schema.SObjectField> sObjectTypeToExternalId) {
        for(Schema.SObjectType sObjectType : sObjectTypeToExternalId.keySet()) {
            handleRegisterType(sObjectType, sObjectTypeToExternalId.get(sObjectType));
        }
    }

    private void handleRegisterType(Schema.SObjectType sObjectType, Schema.SObjectField externalIdField) {
        String sObjectName = sObjectType.getDescribe().getName();
        // check if SObject type is already registered
        if(!registeredSObjectTypes.contains(sObjectName)) {
            // register type
            registeredSObjectTypes.add(sObjectName);
            externalIdByType.put(sObjectName, externalIdField);
            // create maps
            upsertMapByType.put(sObjectName, new Map<String, SObject>());
            deleteMapByType.put(sObjectName, new Map<String, SObject>());
        }
    }

    private void assertForSupportedSObjectType(String sObjectType) {
        if(!registeredSObjectTypes.contains(sObjectType)) {
            throw new UnitOfWorkException(
					String.format(
							'SObject type [{0}] is not supported by this unit of work',
							new List<String> { sObjectType }
					)
			);
        }
    }

    private void assertForExternalIdValue(String sObjectType, String externalId) {
        if(String.isBlank(externalId)) {
            throw new UnitOfWorkException(
                String.format(
                    'External Id field cannot be empty for [{0}]',
                    new List<String> { sObjectType }
                )
			);
        }
    }

    public void registerUpsert(SObject record) {
        // get and assert SObject type
        String sObjectType = record.getSObjectType().getDescribe().getName();
        assertForSupportedSObjectType(sObjectType);
        // get available record fields
        Set<String> recordFields = record.getSObjectType().getDescribe().fields.getMap().keySet();

        // get and assert SObject External Id field value
        String externalId = (String)record.get(externalIdByType.get(sObjectType));
        assertForExternalIdValue(sObjectType, externalId);

        // check if record was already registered
        if(upsertMapByType.get(sObjectType).containsKey(externalId)) {

            // get populated fields of given record
            Map<String,Object> populatedFields = record.getPopulatedFieldsAsMap();
            // get already registered record
            SObject registeredRecord = upsertMapByType.get(sObjectType).get(externalId);

            // override populated fields
            for(String fieldName : populatedFields.keySet()) {
                // check if populated field exists - otherwise it's a related object
                if(!recordFields.contains(fieldName.toLowerCase())) {
                    SObject relatedObject = record.getSObject(fieldName);
                    registeredRecord.putSObject(fieldName, relatedObject);
                } else {
                    registeredRecord.put(fieldName, populatedFields.get(fieldName));
                }
            }

            // override registered record
            upsertMapByType.get(sObjectType).put(externalId,registeredRecord);

        } else {
            // register new record
            upsertMapByType.get(sObjectType).put(externalId,record);
        }
    }

    public void registerDelete(SObject record) {
        // get and assert SObject type
        String sObjectType = record.getSObjectType().getDescribe().getName();
        assertForSupportedSObjectType(sObjectType);
        // get and assert SObject External Id field value
        String externalId = (String)record.get(externalIdByType.get(sObjectType));
        assertForExternalIdValue(sObjectType, externalId);

        // register record to delete
        deleteMapByType.get(sObjectType).put(externalId,record);
    }

    public void commitWork() {
        Savepoint sp = Database.setSavePoint();
        try {

            for(String sObjectType : registeredSObjectTypes) {
                System.debug(LoggingLevel.INFO, 'UOW - Processing Object Type: ' + sObjectType);

                Schema.SObjectField externalIdField = externalIdByType.get(sObjectType);
                Map<String, SObject> upsertMap = upsertMapByType.get(sObjectType);
                Map<String, SObject> deleteMap = deleteMapByType.get(sObjectType);

                Set<String> externalIdsToQuery = new Set<String>();
                externalIdsToQuery.addAll(upsertMap.keySet());
                externalIdsToQuery.addAll(deleteMap.keySet());

                List<SObject> extistingRecords = Database.query(
                    String.format(
                        'SELECT Id, {1} FROM {0} WHERE {1} IN :externalIdsToQuery',
                        new List<String> { sObjectType, externalIdField.getDescribe().getName() }
                    )
                );

                Map<String,String> sfIdByExternalId = new Map<String,String>();
                for(SObject existingRecord : extistingRecords) {
                    sfIdByExternalId.put((String)existingRecord.get(externalIdField), (String)existingRecord.get('Id'));
                }

                List<SObject> insertList = new List<SObject>();
                List<SObject> updateList = new List<SObject>();
                List<SObject> deleteList = new List<SObject>();

                for(SObject record : upsertMap.values()) {
                    String externalIdValue = (String)record.get(externalIdField);
                    if(!sfIdByExternalId.containsKey(externalIdValue)) {
                        insertList.add(record);
                    } else {
                        record.put('Id', sfIdByExternalId.get(externalIdValue));
                        updateList.add(record);
                    }
                }

                for(SObject record : deleteMap.values()) {
                    String externalIdValue = (String)record.get(externalIdField);
                    if(sfIdByExternalId.containsKey(externalIdValue)) {
                        record.put('Id', sfIdByExternalId.get(externalIdValue));
                        deleteList.add(record);
                    }
                }

                System.debug(LoggingLevel.INFO, 'UOW - insertList: ' + insertList);
                System.debug(LoggingLevel.INFO, 'UOW - updateList: ' + updateList);
                System.debug(LoggingLevel.INFO, 'UOW - deleteList: ' + deleteList);

                if(!insertList.isEmpty()) insert insertList;
                if(!updateList.isEmpty()) update updateList;
                if(!deleteList.isEmpty()) delete deleteList;
            }

        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        }
    }
}
