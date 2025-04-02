public class WarehouseShipmentItemConfirmReceivedReq {
    @AuraEnabled
    public Integer id { get; set; }
    
    @AuraEnabled
    public Integer quantityReceived { get; set; }
    
    @AuraEnabled
    public String lotNumber { get; set; }
    
    @AuraEnabled
    public String lpn { get; set; }
    
    @AuraEnabled
    public DateTime expiresDateTimeUtc { get; set; }

    @AuraEnabled
    public String warehouseShipmentItemId { get; set; }

    @AuraEnabled
    public String note { get; set; }
} 