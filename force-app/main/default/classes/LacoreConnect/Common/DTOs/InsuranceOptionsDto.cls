/**
 * @description DTO for insurance options
 */
@TestVisible
public class InsuranceOptionsDto {
    @AuraEnabled public String provider;
    @AuraEnabled public Boolean insureShipment;
    @AuraEnabled public Decimal insuredValue;
} 