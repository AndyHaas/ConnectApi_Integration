public class RateItemDto {
    @AuraEnabled public String sku { get; set; }
    @AuraEnabled public Integer quantity { get; set; }
    @AuraEnabled public Decimal weight { get; set; }
    @AuraEnabled public String weightUnit { get; set; }
    @AuraEnabled public Decimal length { get; set; }
    @AuraEnabled public Decimal width { get; set; }
    @AuraEnabled public Decimal height { get; set; }
    @AuraEnabled public String dimensionUnit { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 