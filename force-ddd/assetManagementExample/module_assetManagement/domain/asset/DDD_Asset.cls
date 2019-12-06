public interface DDD_Asset extends DomainObject {

    void changeAssetStatus(DDD_AssetStatus newStatus);

    // ---------------------------------------------------------------------------------
    // Inner Entity Properties
    // ---------------------------------------------------------------------------------

    String getAssetName();
    void setAssetName(String assetName);

    String getAssetType();
    void setAssetType(String assetType);

    String getEmployeeId();
    void setEmployeeId(String employeeId);    

    Date getAssignmentStartDate();
    void setAssignmentStartDate(Date assignmentStartDate);    

}
