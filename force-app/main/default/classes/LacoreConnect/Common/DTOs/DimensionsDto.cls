/**
 * @description DTO for package dimensions
 */
@TestVisible
public class DimensionsDto {
    @AuraEnabled public Decimal length;
    @AuraEnabled public Decimal width;
    @AuraEnabled public Decimal height;
} 