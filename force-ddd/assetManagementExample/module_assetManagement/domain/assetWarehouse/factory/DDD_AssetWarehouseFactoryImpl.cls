public class DDD_AssetWarehouseFactoryImpl implements DDD_AssetWarehouseFactory {
    
    public DDD_AssetWarehouse constructAssetWarehouse(String warehouseCode, List<sObject> availableAssets) {
        List<Asset__c> assets = (List<Asset__c>)availableAssets;

        DDD_AssetWarehouse assetWarehouse = (DDD_AssetWarehouse)AppConfig.Domain.newInstance(DDD_AssetWarehouse.class);
        assetWarehouse.setRecordId(warehouseCode);
        assetWarehouse.construct();

        // for (Asset__c assets : availableAssets) {
        //     setAssetQuantity
        // }

        assetWarehouse.setAssetQuantity('Laptop 13 inch', 2);
        assetWarehouse.setAssetQuantity('Laptop 15 inch', 5);

        return assetWarehouse;

    }

}
