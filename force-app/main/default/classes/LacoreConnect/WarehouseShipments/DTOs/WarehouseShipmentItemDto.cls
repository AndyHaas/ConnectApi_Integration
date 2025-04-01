public class WarehouseShipmentItemDto {
    @AuraEnabled
    public String id { get; set; }
    
    @AuraEnabled
    public Decimal weight { get; set; }
    
    @AuraEnabled
    public Decimal landingCost { get; set; }
    
    @AuraEnabled
    public Decimal quantity { get; set; }
    
    @AuraEnabled
    public Decimal quantityReceived { get; set; }
    
    @AuraEnabled
    public String purchaseOrderItemId { get; set; }
    
    @AuraEnabled
    public String warehouseProductItem { get; set; }
    
    @AuraEnabled
    public String warehouseProductDescription { get; set; }
    
    @AuraEnabled
    public String warehouseProductId { get; set; }
    
    @AuraEnabled
    public String lotNumber { get; set; }
    
    @AuraEnabled
    public String lpn { get; set; }
    
    @AuraEnabled
    public String warehouseShipmentId { get; set; }
    
    @AuraEnabled
    public DateTime expiresDateTimeUtc { get; set; }
} 