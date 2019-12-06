public class AppEventManager {
    
    private static final Map<String, List<Type>> eventHandlersMap = new Map<String, List<Type>>{
        'EmployeeHire' => new List<Type>{DDD_EmployeeHiredEvent.class}
    };

    public static void handleEvent(String eventType, String eventPayload) {
        if (eventHandlersMap.containsKey(eventType)) {
            for (Type eventHandlerType : eventHandlersMap.get(eventType)) {
                DomainEventHandler handler = (DomainEventHandler) eventHandlerType.newInstance();
                handler.construct(eventPayload);
                handler.execute();
            }
        }

    }
}
