public class WebhookDto {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public String storefrontId { get; set; }
    @AuraEnabled public String onEvent { get; set; }
    @AuraEnabled public String toURL { get; set; }
    @AuraEnabled public Boolean enabled { get; set; }
    @AuraEnabled public DateTime createdAt { get; set; }
    @AuraEnabled public DateTime updatedAt { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 