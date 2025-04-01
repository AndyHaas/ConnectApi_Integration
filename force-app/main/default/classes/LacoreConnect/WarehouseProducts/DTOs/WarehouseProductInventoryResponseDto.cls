public class WarehouseProductInventoryResponseDto {
    @AuraEnabled
    public List<WarehouseProductInventoryDto> items;
    
    @AuraEnabled
    public Integer perPage;
    
    @AuraEnabled
    public Integer total;
    
    @AuraEnabled
    public Integer page;
    
    @AuraEnabled
    public Integer totalPages;
} 