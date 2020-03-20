public with sharing class AST_AssetReservationCtrl {
    @AuraEnabled
    public static AST_Schema.Employee getEmployee(String employeeId) {
        AST_EmployeeSelector employeeSelector = new AST_EmployeeSelector();
        return employeeSelector.getEmployeeById(employeeId);
    }

    @AuraEnabled
    public static void assignAsset(String assetType, String employeeId, String location, Date startDate) {
        AST_Commands.AssignAsset assignAssetCmd = new AST_Commands.AssignAsset(assetType, employeeId, location, startDate);
        AST_AssetMgmtService assetMgmtService = new AST_AssetMgmtService();
 
        try {
            assetMgmtService.assignAsset(assignAssetCmd);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
 
 }
 