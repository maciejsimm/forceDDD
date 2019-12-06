public class AppConfig {

    private static Boolean triggersOff = false;

    public static void setTriggersOff() {
        AppConfig.triggersOff = true;
    }

    public static Boolean areTriggersOff() {
        return AppConfig.triggersOff;
    }

    public static final AppFactory.RepositoryFactory Repository = 
        new AppFactory.RepositoryFactory(
            new Map<Type,Type> {
                DDD_AssetWarehouseRepository.class => DDD_AssetWarehouseRepositoryImpl.class,
                DDD_AssetWarehouseFactory.class => DDD_AssetWarehouseFactoryImpl.class,
                DDD_EmployeeRepository.class => DDD_EmployeeRepositoryImpl.class
            }
        );

    public static final AppFactory.ServiceFactory Service = 
        new AppFactory.ServiceFactory(
            new Map<Type,Type> {
                DDD_AssetManagementService.class => DDD_AssetManagementServiceImpl.class
            }
        );


    public static final AppFactory.DomainFactory Domain = 
        new AppFactory.DomainFactory(
            new Map<Type,Type> {
                DDD_Asset.class => DDD_AssetImpl.class,
                DDD_AssetWarehouse.class => DDD_AssetWarehouseImpl.class
            }
        );

    public static final AppFactory.UnitOfWorkFactory UnitOfWork = 
        new AppFactory.UnitOfWorkFactory();

}
