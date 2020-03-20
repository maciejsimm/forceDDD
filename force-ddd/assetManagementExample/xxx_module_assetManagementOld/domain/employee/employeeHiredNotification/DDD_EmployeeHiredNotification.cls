public class DDD_EmployeeHiredNotification {
    
    public String notificationUserId {get;set;}
    public String employeeId {get;set;}
    public String employeeLocation {get;set;}
    public Date employeeStartDate {get;set;}

    public DDD_EmployeeHiredNotification(String notifyUserId,
                                         String employeeId,
                                         String employeeLocation,
                                         Date employeeStartDate) {

        this.notificationUserId = notifyUserId;
        this.employeeId = employeeId;
        this.employeeLocation = employeeLocation;
        this.employeeStartDate = employeeStartDate;
    }

}
