public class WarehouseDtoPaginatedItemsResponse {
    @AuraEnabled
    public List<WarehouseDto> items;
    
    @AuraEnabled
    public Integer perPage;
    
    @AuraEnabled
    public Integer total;
    
    @AuraEnabled
    public Integer page;
    
    @AuraEnabled
    public Integer totalPages;
} 