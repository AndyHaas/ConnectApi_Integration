public class BulkShipmentDto {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String orderNumber { get; set; }
    @AuraEnabled public String customReferenceNumber { get; set; }
    @AuraEnabled public String customerPo { get; set; }
    @AuraEnabled public String billOfLading { get; set; }
    @AuraEnabled public String carrierShippedWith { get; set; }
    @AuraEnabled public String serviceShippedWith { get; set; }
    @AuraEnabled public String carrierTrackingNumber { get; set; }
    @AuraEnabled public DateTime shipDateTimeUtc { get; set; }
    @AuraEnabled public String orderStatus { get; set; }
    @AuraEnabled public String fromWarehouseId { get; set; }
    @AuraEnabled public String brandId { get; set; }
    @AuraEnabled public ShipAddressDto shipTo { get; set; }
    @AuraEnabled public List<BulkShipmentItemDto> items { get; set; }
    @AuraEnabled public DateTime createDateTimeUtc { get; set; }
    @AuraEnabled public DateTime modifyDateTimeUtc { get; set; }
    @AuraEnabled public List<CustomFieldDto> customFields { get; set; }
}