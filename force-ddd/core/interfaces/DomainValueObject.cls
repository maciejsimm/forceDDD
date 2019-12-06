public interface DomainValueObject {

    Boolean isEqualTo(DomainValueObject valueObject);
    Object getValue();

}
