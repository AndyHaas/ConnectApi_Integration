public class WarehouseProductInventoryDto {
    @AuraEnabled
    public String id;
    
    @AuraEnabled
    public String item;
    
    @AuraEnabled
    public String description;
    
    @AuraEnabled
    public String warehouseProductId;
    
    @AuraEnabled
    public String warehouseId;
    
    @AuraEnabled
    public String brandId;
    
    @AuraEnabled
    public String locationCode;
    
    @AuraEnabled
    public String lpn;
    
    @AuraEnabled
    public String lotNumber;
    
    @AuraEnabled
    public String shipmentReferenceNumber;
    
    @AuraEnabled
    public DateTime expirationDate;
    
    @AuraEnabled
    public Integer receivedQuantity;
    
    @AuraEnabled
    public Integer quantity;
    
    @AuraEnabled
    public Integer quantityAvailable;
    
    @AuraEnabled
    public Integer quantityOnHold;
    
    @AuraEnabled
    public Integer quantityUnavailable;
    
    @AuraEnabled
    public Decimal landingCost;
    
    @AuraEnabled
    public Decimal weightMetric;
    
    @AuraEnabled
    public Boolean isOnHold;
    
    @AuraEnabled
    public Boolean isQuarantined;
} 