/**
 * @description DTO for payment method information
 */
@TestVisible
public class PaymentMethodDto {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String type { get; set; }
    @AuraEnabled public String cardNumber { get; set; }
    @AuraEnabled public String cardType { get; set; }
    @AuraEnabled public String expirationMonth { get; set; }
    @AuraEnabled public String expirationYear { get; set; }
    @AuraEnabled public String cvv { get; set; }
    @AuraEnabled public String token { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 