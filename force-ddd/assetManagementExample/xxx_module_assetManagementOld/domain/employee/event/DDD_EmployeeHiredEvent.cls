public class DDD_EmployeeHiredEvent implements DomainEventHandler {
    
    private String employeeId {get;set;}
    private Date employmentStartDate {get;set;}
    private String employeePosition {get;set;}
    private String employeeLocation {get;set;}

    public DDD_EmployeeHiredEvent construct(String eventPayload) {

        Map<String, Object> eventData = (Map<String, Object>)JSON.deserializeUntyped(eventPayload);
        this.employeeId = (String)eventData.get('employeeId');
        this.employmentStartDate = Date.valueOf('2019-12-15');
        this.employeePosition = (String)eventData.get('employeePosition');
        this.employeeLocation = (String)eventData.get('employeeLocation');

        System.debug('DDD_EmployeeHiredEvent event: ' + this);

        return this;
    }   

    public void execute() {

        DDD_EmployeeRepository empRepository = (DDD_EmployeeRepository)AppConfig.Repository.newInstance(DDD_EmployeeRepository.class);

        DDD_EmployeeHiredNotification hireEvent = new DDD_EmployeeHiredNotification('adminID',
                                                                                    this.employeeId,
                                                                                    this.employeeLocation,
                                                                                    this.employmentStartDate);

        System.debug('DDD_EmployeeHiredEvent executed. Hire event:  ' + hireEvent);
        empRepository.saveEmployeeHiredNotification(hireEvent);

    }

}
