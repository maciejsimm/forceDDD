public virtual class AST_WarehouseRepository {
    public virtual AST_Warehouse getWarehouseByLocation(String location) {
        AST_WarehouseFactory factory = new AST_WarehouseFactory();
       
        // Query database
        List<Asset__c> assets = [SELECT Id, Name
                                   FROM Asset__c];
   
        // Construct Aggregate Domain Object
        AST_Warehouse warehouse = factory.constructWarehouse(assets);
        return warehouse;
    }
 }
 
 