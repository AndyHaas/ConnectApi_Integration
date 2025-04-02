/**
 * @description DTO for address information
 */
@TestVisible
public class AddressDto {
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public String company { get; set; }
    @AuraEnabled public String address1 { get; set; }
    @AuraEnabled public String address2 { get; set; }
    @AuraEnabled public String city { get; set; }
    @AuraEnabled public String state { get; set; }
    @AuraEnabled public String zip { get; set; }
    @AuraEnabled public String country { get; set; }
    @AuraEnabled public String phone { get; set; }
    @AuraEnabled public String email { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
} 