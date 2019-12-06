public virtual class DomainObjectBase implements DomainObject {

    // ---------------------------------------------------------------------------------
    // Setup Objects
    // ---------------------------------------------------------------------------------

    public virtual String getObjectPrefix() {
        return 'DDD';
    }

    // ---------------------------------------------------------------------------------
    // Domain Object Core
    // ---------------------------------------------------------------------------------

    public String recordId {get; set;}

    public String getRecordId() {
        return this.recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public virtual void construct(Map<String, Object> fields) {
        this.fields = fields;

        if (this.getRecordId() == null) {
            this.setRecordId(this.generateRandomExternalId(this.getObjectPrefix()));
        }
    }

    public virtual void construct() {
        this.fields = new Map<String, Object>();

        if (this.getRecordId() == null) {
            this.setRecordId(this.generateRandomExternalId(this.getObjectPrefix()));
        }
    }

    private Map<String, Object> fields {get;set;}

    public Map<String, Object> getFields() {
        return this.fields;
    }

    public void setField(String fieldName, Object fieldValue) {
        this.fields.put(fieldName, fieldValue);
    }
    
    public Object getField(String fieldName) {
        return this.fields.get(fieldName);
    }

    // ---------------------------------------------------------------------------------
    // Handling Record TECH ID
    // ---------------------------------------------------------------------------------

    private String generateRandomExternalId(String objectTrigram) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String randStr = '';
        while (randStr.length() < 10) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return objectTrigram + '00' + randStr.toUpperCase(); 
    }

    // ---------------------------------------------------------------------------------
    // Domain Events & Handlers
    // ---------------------------------------------------------------------------------

    private Map<String, List<DomainEventHandler>> eventHandlersMap {get;set;}

    public void registerEventHandler(String eventName, DomainEventHandler eventHandler) {
        if (eventHandlersMap == null) {
            eventHandlersMap = new Map<String, List<DomainEventHandler>>();
        }

        if (!eventHandlersMap.containsKey(eventName)) {
            eventHandlersMap.put(eventName, new List<DomainEventHandler>{eventHandler});
        } else {
            List<DomainEventHandler> alreadyRegisteredHandlers = eventHandlersMap.get(eventName);
            alreadyRegisteredHandlers.add(eventHandler);
        }
    }

    public void fireEvent(String eventName) {
        // if (eventHandlersMap != null && eventHandlersMap.containsKey(eventName)) {
        //     List<DomainEventHandler> registeredHandlers = eventHandlersMap.get(eventName);
        //     for (DomainEventHandler eventHandler : registeredHandlers) {
        //         eventHandler.execute(this);
        //     }
        // } else {
        //     System.debug(LoggingLevel.FINE, 'No handlers registered for event: ' + eventName);
        // }
    }

}
