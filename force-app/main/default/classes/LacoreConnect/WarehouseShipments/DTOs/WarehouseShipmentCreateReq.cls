public class WarehouseShipmentCreateReq {
    @AuraEnabled
    public String vendorId { get; set; }
    
    @AuraEnabled
    public Integer brandId { get; set; }
    
    @AuraEnabled
    public String referenceNumber { get; set; }
    
    @AuraEnabled
    public String billOfLading { get; set; }
    
    @AuraEnabled
    public String type { get; set; }
    
    @AuraEnabled
    public String fromWarehouseId { get; set; }
    
    @AuraEnabled
    public String toWarehouseId { get; set; }
    
    @AuraEnabled
    public String name { get; set; }
    
    @AuraEnabled
    public String purchaseOrderId { get; set; }
    
    @AuraEnabled
    public List<WarehouseShipmentItemCreateReq> items { get; set; }
    
    @AuraEnabled
    public String notes { get; set; }
    
    @AuraEnabled
    public String packingListId { get; set; }
} 