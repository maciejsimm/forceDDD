public interface DomainRepository {
    
    void setUnitOfWork(UnitOfWork uow);

    Map<Schema.SObjectType, Schema.SObjectField> getSObjectTypeToExtIdFieldMap();

}
