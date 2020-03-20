public virtual class AST_WarehouseFactory {
    public virtual AST_Warehouse constructWarehouse(List<Asset__c> assets) {
        AST_Warehouse result = new AST_Warehouse();
       
        for (Asset__c ast : assets) {
            // result.put(...)
            // execute some mapping logic
        }
       
        return result;
    }
 }