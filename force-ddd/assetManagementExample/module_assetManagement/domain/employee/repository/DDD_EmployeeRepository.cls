public interface DDD_EmployeeRepository extends DomainRepository {

    void saveEmployeeHiredNotification(DDD_EmployeeHiredNotification notification);

}