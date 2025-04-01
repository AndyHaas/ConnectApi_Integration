public class WarehouseShipmentDto {
    @AuraEnabled
    public String id { get; set; }
    
    @AuraEnabled
    public DateTime createDateTimeUtc { get; set; }
    
    @AuraEnabled
    public DateTime modifyDateTimeUtc { get; set; }
    
    @AuraEnabled
    public DateTime receivedAtDateTimeUtc { get; set; }
    
    @AuraEnabled
    public DateTime expectedDateTimeUtc { get; set; }
    
    @AuraEnabled
    public String vendorId { get; set; }
    
    @AuraEnabled
    public String brandId { get; set; }
    
    @AuraEnabled
    public String referenceNumber { get; set; }
    
    @AuraEnabled
    public String billOfLading { get; set; }
    
    @AuraEnabled
    public Integer type { get; set; }
    
    @AuraEnabled
    public String fromWarehouseId { get; set; }
    
    @AuraEnabled
    public String toWarehouseId { get; set; }
    
    @AuraEnabled
    public String name { get; set; }
    
    @AuraEnabled
    public String purchaseOrderId { get; set; }
    
    @AuraEnabled
    public List<WarehouseShipmentItemDto> items { get; set; }
    
    @AuraEnabled
    public String status { get; set; }
    
    @AuraEnabled
    public String notes { get; set; }
    
    @AuraEnabled
    public String packingListId { get; set; }
} 