public class WarehouseShipmentConfirmReceivedReq {
    @AuraEnabled
    public List<WarehouseShipmentItemConfirmReceivedReq> items { get; set; }
    
    @AuraEnabled
    public String note { get; set; }
} 