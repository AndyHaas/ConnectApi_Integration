public class RateRequestDto {
    @AuraEnabled public String brandId { get; set; }
    @AuraEnabled public String warehouseId { get; set; }
    @AuraEnabled public AddressDto origin { get; set; }
    @AuraEnabled public AddressDto destination { get; set; }
    @AuraEnabled public List<RateItemDto> items { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 