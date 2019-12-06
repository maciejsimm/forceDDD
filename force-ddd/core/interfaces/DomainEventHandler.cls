public interface DomainEventHandler {
    
    DomainEventHandler construct(String eventPayload);

    void execute();

}