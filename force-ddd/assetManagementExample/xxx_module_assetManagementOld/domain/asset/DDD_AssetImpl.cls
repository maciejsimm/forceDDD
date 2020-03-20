public class DDD_AssetImpl extends DomainObjectBase implements DDD_Asset {

    public void changeAssetStatus(DDD_AssetStatus newAssetStatus) {
        if (!isValidStatusTransition(newAssetStatus)) {
            throw new InvalidAssetStatusException();
        }
        this.assetStatus = newAssetStatus;
    }

    // ---------------------------------------------------------------------------------
    // Helper Methods
    // ---------------------------------------------------------------------------------
    private Boolean isValidStatusTransition(DDD_AssetStatus newAssetStatus) {
        // some validation logic here ...
        return true;
    }

    public class InvalidAssetStatusException extends Exception {}

    // ---------------------------------------------------------------------------------
    // Inner Entity Properties
    // ---------------------------------------------------------------------------------

    private DDD_AssetStatus assetStatus {get;set;}
    private String assetName {get;set;}
    private String assetType {get;set;}
    private String employeeId {get;set;}
    private Date assignmentStartDate {get;set;}

    public String getAssetName() {
        return this.assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getAssetType() {
        return this.assetType;
    }

    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    public String getEmployeeId() {
        return this.employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public Date getAssignmentStartDate() {
        return this.assignmentStartDate;
    }

    public void setAssignmentStartDate(Date assignmentStartDate) {
        this.assignmentStartDate = assignmentStartDate;
    }

}
