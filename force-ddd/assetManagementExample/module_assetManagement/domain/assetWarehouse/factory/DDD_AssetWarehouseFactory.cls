public interface DDD_AssetWarehouseFactory {

    DDD_AssetWarehouse constructAssetWarehouse(String warehouseCode, List<sObject> availableAssets);

}
