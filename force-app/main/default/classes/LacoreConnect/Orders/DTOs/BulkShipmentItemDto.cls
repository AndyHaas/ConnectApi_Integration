public class BulkShipmentItemDto {
    @AuraEnabled public String item { get; set; }
    @AuraEnabled public Double grossWeight { get; set; }
    @AuraEnabled public Double quantity { get; set; }
    @AuraEnabled public List<CustomFieldDto> customFields { get; set; }
    @AuraEnabled public List<FulfillmentInfoItemDto> fulfillmentInfo { get; set; }
} 