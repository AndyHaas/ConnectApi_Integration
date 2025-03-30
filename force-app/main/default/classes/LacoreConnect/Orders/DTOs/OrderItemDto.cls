public class OrderItemDto {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String sku { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public Integer quantity { get; set; }
    @AuraEnabled public Decimal price { get; set; }
    @AuraEnabled public Decimal weight { get; set; }
    @AuraEnabled public String weightUnit { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 