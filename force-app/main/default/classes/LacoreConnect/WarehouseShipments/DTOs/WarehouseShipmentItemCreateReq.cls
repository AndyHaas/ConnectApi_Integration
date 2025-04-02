public class WarehouseShipmentItemCreateReq {
    @AuraEnabled
    public String warehouseProductId { get; set; }
    
    @AuraEnabled
    public Integer quantity { get; set; }
    
    @AuraEnabled
    public String lotNumber { get; set; }
    
    @AuraEnabled
    public String lpn { get; set; }
    
    @AuraEnabled
    public DateTime expiresDateTimeUtc { get; set; }
    
    @AuraEnabled
    public String purchaseOrderItemId { get; set; }
} 