public class AST_Warehouse {
   public Map<String, List<AST_Asset>> assetsByTypeMap;

   public AST_Asset getSpareAsset(String assetType) {
       if (noAssetOfParticularTypeIsAvailable()) {
           throw new AST_AssetUnavailableException();
       }
       return this.assetsByTypeMap.get(assetType)[0];
   }

   private Boolean noAssetOfParticularTypeIsAvailable() {
       return false;
   }

   public class AST_AssetUnavailableException extends Exception {}
}
