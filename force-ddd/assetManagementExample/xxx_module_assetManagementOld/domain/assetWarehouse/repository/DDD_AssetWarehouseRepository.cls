public interface DDD_AssetWarehouseRepository extends DomainRepository {
    
    DDD_AssetWarehouse getAssetWarehouse(String assetWarehouseLocation);

    void saveAssetReservation(DDD_Asset asset);

}
