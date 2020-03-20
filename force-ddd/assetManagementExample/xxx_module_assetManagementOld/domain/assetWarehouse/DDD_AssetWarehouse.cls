public interface DDD_AssetWarehouse extends DomainObject {

    DDD_Asset assignAsset(String assetType, Date assignmentStartDate, String employeeId);

    // ---------------------------------------------------------------------------------
    // Inner Entity Properties
    // ---------------------------------------------------------------------------------

    void setAssetQuantity(String assetType, Integer quantity);

}
