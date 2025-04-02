/**
 * @description DTO for advanced shipping options
 */
@TestVisible
public class AdvancedOptionsDto {
    @AuraEnabled public Integer warehouseId;
    @AuraEnabled public Boolean nonMachinable;
    @AuraEnabled public Boolean saturdayDelivery;
    @AuraEnabled public Boolean containsAlcohol;
    @AuraEnabled public String customField1;
    @AuraEnabled public String customField2;
    @AuraEnabled public String customField3;
    @AuraEnabled public String source;
    @AuraEnabled public Boolean mergedOrSplit;
    @AuraEnabled public List<Integer> mergedIds;
    @AuraEnabled public Integer parentId;
    @AuraEnabled public String billToParty;
    @AuraEnabled public String billToAccount;
    @AuraEnabled public String billToPostalCode;
    @AuraEnabled public String billToCountryCode;
    @AuraEnabled public String billToMyOtherAccount;
    @AuraEnabled public Integer storeId;
} 