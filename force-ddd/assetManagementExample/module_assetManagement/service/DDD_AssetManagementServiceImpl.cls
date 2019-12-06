public class DDD_AssetManagementServiceImpl implements DDD_AssetManagementService {

    public Boolean assignAsset(String assetType, Date assignmentStartDate, String assetLocation, String employeeId) {
        AppConfig.setTriggersOff();
        UnitOfWork uow = AppConfig.UnitOfWork.newInstance();

        // Initialize Aggregate from Repository
        DDD_AssetWarehouseRepository assetWarehouseRepository = (DDD_AssetWarehouseRepository)AppConfig.Repository.newInstance(DDD_AssetWarehouseRepository.class);
        assetWarehouseRepository.setUnitOfWork(uow);
        DDD_AssetWarehouse assetWarehouse = assetWarehouseRepository.getAssetWarehouse(assetLocation);

        // Execute business method on the Aggregate object
        DDD_Asset asset = assetWarehouse.assignAsset(assetType, assignmentStartDate, employeeId);

        // Save aggregate
        assetWarehouseRepository.saveAssetReservation(asset);
        
        // Commit work
        uow.commitWork();

        return true;
    }

}