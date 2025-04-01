public class WarehouseProductDto {
    @AuraEnabled
    public String id;

    @AuraEnabled
    public String item;
    
    @AuraEnabled
    public String warehouseId;
    
    @AuraEnabled
    public String sku;
    
    @AuraEnabled
    public String name;
    
    @AuraEnabled
    public String description;
    
    @AuraEnabled
    public Decimal price;
    
    @AuraEnabled
    public Integer quantity;

    @AuraEnabled
    public Integer quantityUnavailable;
    
    @AuraEnabled
    public String status;
    
    @AuraEnabled
    public DateTime createdAt;
    
    @AuraEnabled
    public DateTime updatedAt;
} 