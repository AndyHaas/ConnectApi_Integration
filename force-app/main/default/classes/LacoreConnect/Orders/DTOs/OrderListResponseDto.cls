public class OrderListResponseDto {
    @AuraEnabled public List<OrderDto> orders { get; set; }
    @AuraEnabled public Integer total { get; set; }
    @AuraEnabled public Integer page { get; set; }
    @AuraEnabled public Integer pageSize { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 