public class WarehouseShipmentDtoPaginatedItemsResponse {
    @AuraEnabled
    public List<WarehouseShipmentDto> items { get; set; }
    
    @AuraEnabled
    public Integer perPage { get; set; }
    
    @AuraEnabled
    public Integer total { get; set; }
    
    @AuraEnabled
    public Integer page { get; set; }
    
    @AuraEnabled
    public Integer totalPages { get; set; }
} 