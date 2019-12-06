public interface DomainObject {

    String getRecordId();
    void setRecordId(String recordId);

    String getObjectPrefix();

    void construct();
    void construct(Map<String, Object> fields);

    void fireEvent(String eventName);

    Map<String, Object> getFields();
    void setField(String fieldName, Object fieldValue);

}
