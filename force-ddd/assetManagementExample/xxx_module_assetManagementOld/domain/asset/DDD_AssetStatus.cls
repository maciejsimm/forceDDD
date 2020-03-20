public class DDD_AssetStatus implements DomainValueObject {

    public static final DDD_AssetStatus STATUS_ORDERED = new DDD_AssetStatus('Ordered');
    public static final DDD_AssetStatus STATUS_NEW = new DDD_AssetStatus('New');
    public static final DDD_AssetStatus STATUS_RESERVED = new DDD_AssetStatus('Reserved');
    public static final DDD_AssetStatus STATUS_IN_USE = new DDD_AssetStatus('In Use');
    public static final DDD_AssetStatus STATUS_AVAILABLE = new DDD_AssetStatus('Available');
    public static final DDD_AssetStatus STATUS_BROKEN = new DDD_AssetStatus('Broken');
    public static final DDD_AssetStatus STATUS_SCRAP = new DDD_AssetStatus('Scrapped');

    private DDD_AssetStatus(String status) {
        this.status = status;
    }

    private String status {get;set;}

    public String getStatus() {
        return this.status;
    }

    public Boolean isEqualTo(DomainValueObject anotherAssetStatusObject) {
        DDD_AssetStatus anotherAssetStatus = (DDD_AssetStatus)anotherAssetStatusObject;
        return this.getStatus() == anotherAssetStatus.getStatus();
    }

    public Object getValue() {
        return getStatus();
    }

}