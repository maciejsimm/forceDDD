public class DDD_AssetWarehouseRepositoryImpl implements DDD_AssetWarehouseRepository {

    public DDD_AssetWarehouse getAssetWarehouse(String assetWarehouseLocationCode) {

        DDD_AssetWarehouseFactory assetWarehouseFactory = (DDD_AssetWarehouseFactory)AppConfig.Repository.newInstance(DDD_AssetWarehouseFactory.class);

        List<Asset__c> assets = [SELECT Id, Name, Location_Code__c, Serial_Number__c, Status__c, OwnerId
                                   FROM Asset__c
                                  WHERE Location_Code__c = :assetWarehouseLocationCode
                                    AND Status__c IN ('New', 'Available')];

        DDD_AssetWarehouse assetWarehouse = assetWarehouseFactory.constructAssetWarehouse(assetWarehouseLocationCode, assets);

        return assetWarehouse;
    }

    public void saveAssetReservation(DDD_Asset asset) {
        
    }

    // ---------------------------------------------------------------------------------
    // Repository Utility Methods
    // ---------------------------------------------------------------------------------

    public Map<Schema.SObjectType, Schema.SObjectField> getSObjectTypeToExtIdFieldMap() {
        return new Map<Schema.SObjectType, Schema.SObjectField>{
            Asset__c.sObjectType => Asset__c.Serial_Number__c
        };
    }

    private UnitOfWork uow {get;set;}
    public void setUnitOfWork(UnitOfWork uow) {
        uow.registerSObjectTypes(this.getSObjectTypeToExtIdFieldMap());
        this.uow = uow;
    }

}
