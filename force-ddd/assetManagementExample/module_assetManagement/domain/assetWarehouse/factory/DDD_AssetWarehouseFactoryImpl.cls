public class DDD_AssetWarehouseFactoryImpl implements DDD_AssetWarehouseFactory {
    
    public DDD_AssetWarehouse constructAssetWarehouse(String warehouseCode, List<sObject> availableAssets) {
        List<Asset__c> assets = (List<Asset__c>)availableAssets;

        DDD_AssetWarehouse assetWarehouse = (DDD_AssetWarehouse)AppConfig.Domain.newInstance(DDD_AssetWarehouse.class);
        assetWarehouse.setRecordId(warehouseCode);
        assetWarehouse.construct();

        return assetWarehouse;

    }

}
