public class DDD_AssetWarehouseImpl extends DomainObjectBase implements DDD_AssetWarehouse {

    public DDD_Asset assignAsset(String assetType, Date assignmentStartDate, String employeeId) {
        
        DDD_Asset assetToAssign = this.getSpareAssetToAssign(assetType, assignmentStartDate);

        // Validating asset availability
        if (assetToAssign == null) {
            throw new AssetUnavailableException();
        }        

        // Assigning asset (using asset methods)
        assetToAssign.setEmployeeId(employeeId);
        assetToAssign.setAssignmentStartDate(assignmentStartDate);
        assetToAssign.changeAssetStatus(DDD_AssetStatus.STATUS_RESERVED);

        return assetToAssign;
    }
    
    public class AssetUnavailableException extends Exception {}

    @testVisible
    private Map<String, Integer> availableAssetsQuantity {get;set;}

    private DDD_Asset getSpareAssetToAssign(String assetType, Date fromDate) {
        if (availableAssetsQuantity.containsKey(assetType)) {
            Integer assetQuantity = availableAssetsQuantity.get(assetType);
            if (assetQuantity > 0) {
                return (DDD_Asset)AppConfig.Domain.newInstance(DDD_Asset.class);
            }
        }
        return null;
    }

}
