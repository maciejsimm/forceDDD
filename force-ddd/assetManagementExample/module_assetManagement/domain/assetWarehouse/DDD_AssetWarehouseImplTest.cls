@isTest
private class DDD_AssetWarehouseImplTest {

    // Given there is a spare asset of particular type at selected location 
    // When I select asset type and assign it to particular employee
    // Then the asset is successfully reserved
    static testMethod void shouldAssetBeReservedSuccessfully() {
        AppConfig.Repository.setMock(DDD_AssetWarehouseRepository.class, new AssetWarehouseRepoImpl());
        
        Test.startTest();
        
        List<Exception> exceptions = new List<Exception>();

        try {
            DDD_AssetWarehouseRepository assetWarehouseRepository = (DDD_AssetWarehouseRepository)AppConfig.Repository.newInstance(DDD_AssetWarehouseRepository.class);
            DDD_AssetWarehouse assetWarehouse = assetWarehouseRepository.getAssetWarehouse('n/a');
            assetWarehouse.assignAsset('Laptop 13"', Date.today(), 'test');
        } catch(Exception ex) {
            exceptions.add(ex);
        }

        Test.stopTest();

        System.assertEquals(0, exceptions.size());

    }

    // Given there is no spare asset at selected location 
    // When I select asset type and assign it to particular employee
    // Then the system notifies me that there is no spare asset of particular type at particular location
    static testMethod void shouldAssetReservationFail() {
        AppConfig.Repository.setMock(DDD_AssetWarehouseRepository.class, new AssetWarehouseRepoImpl());
        
        Test.startTest();
        
        List<Exception> exceptions = new List<Exception>();

        try {
            DDD_AssetWarehouseRepository assetWarehouseRepository = (DDD_AssetWarehouseRepository)AppConfig.Repository.newInstance(DDD_AssetWarehouseRepository.class);
            DDD_AssetWarehouse assetWarehouse = assetWarehouseRepository.getAssetWarehouse('n/a');
            assetWarehouse.assignAsset('iPhone 8 32GB', Date.today(), 'test');
        } catch(Exception ex) {
            exceptions.add(ex);
        }

        Test.stopTest();

        System.assertEquals(1, exceptions.size());

    }

    public class AssetWarehouseRepoImpl implements DDD_AssetWarehouseRepository {
        public DDD_AssetWarehouse getAssetWarehouse(String assetWarehouseLocation) {
            DDD_AssetWarehouseImpl assetWarehouse = new DDD_AssetWarehouseImpl();
            assetWarehouse.availableAssetsQuantity = new Map<String, Integer>{'Laptop 13"' => 1};
            return assetWarehouse;
        }

        public void saveAssetReservation(DDD_Asset asset) {}

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

}
