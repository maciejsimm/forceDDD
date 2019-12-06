public interface UnitOfWork {
    void registerSObjectTypes(Map<Schema.SObjectType, Schema.SObjectField> sObjectTypeToExternalId);
    void registerUpsert(SObject record);
    void registerDelete(SObject record);
    void commitWork();
}