/**
 * @description DTO for paginated API responses
 */
public class PaginatedResponseDto {
    @AuraEnabled public List<Object> items { get; set; }
    @AuraEnabled public Integer perPage { get; set; }
    @AuraEnabled public Integer total { get; set; }
    @AuraEnabled public Integer page { get; set; }
    @AuraEnabled public Integer totalPages { get; set; }
} 