public class AST_Commands {
    public class AssignAsset {
        public String assetType;
        public String employeeId;
        public String location;
        public Date startDate;
       
        public AssignAsset(String assetType, String employeeId, String location, Date startDate) {
            this.assetType = assetType;
            this.employeeId = employeeId;
            this.location = location;
            this.startDate = startDate;
        }
    }
 } 