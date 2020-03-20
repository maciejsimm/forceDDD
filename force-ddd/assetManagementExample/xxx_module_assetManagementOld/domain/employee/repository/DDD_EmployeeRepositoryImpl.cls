public class DDD_EmployeeRepositoryImpl implements DDD_EmployeeRepository {

    public void saveEmployeeHiredNotification(DDD_EmployeeHiredNotification notification) {
        Task taskToSave = new Task();
        taskToSave.OwnerId = '0050x000003YdeH';
        taskToSave.WhoId = notification.employeeId;
        taskToSave.Subject = 'Prepare Equipment';
        taskToSave.ActivityDate = notification.employeeStartDate;
        taskToSave.Description = 'Prepare Equipment: \n' +
                                 '-- for emp: ' + notification.employeeId + '\n' +
                                 '-- for loc: ' + notification.employeeLocation + '\n' +
                                 '-- for date: ' + notification.employeeStartDate + '\n';

        System.debug('DDD_EmployeeRepositoryImpl task to save is: ' + taskToSave);

        insert taskToSave;
    }

    // ---------------------------------------------------------------------------------
    // NOT APPLICABLE - Repository Utility Methods
    // ---------------------------------------------------------------------------------

    public Map<Schema.SObjectType, Schema.SObjectField> getSObjectTypeToExtIdFieldMap() {
        return null;
        // return new Map<Schema.SObjectType, Schema.SObjectField>{
            // not applicable
        // };
    }

    private UnitOfWork uow {get;set;}
    public void setUnitOfWork(UnitOfWork uow) {
        uow.registerSObjectTypes(this.getSObjectTypeToExtIdFieldMap());
        this.uow = uow;
    }

}
