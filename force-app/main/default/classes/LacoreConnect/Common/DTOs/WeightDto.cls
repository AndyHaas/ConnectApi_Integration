/**
 * @description DTO for package weight
 */
@TestVisible
public class WeightDto {
    @AuraEnabled public Decimal value;
    @AuraEnabled public String units;
} 