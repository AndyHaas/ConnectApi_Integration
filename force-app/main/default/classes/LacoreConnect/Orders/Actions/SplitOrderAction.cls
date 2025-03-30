public with sharing class SplitOrderAction {
    @InvocableMethod(label='Split Order' description='Split order into multiple orders in Lacore Connect' category='Lacore Connect')
    public static List<SplitOrderResponse> execute(List<SplitOrderRequest> requests) {
        List<SplitOrderResponse> responses = new List<SplitOrderResponse>();
        
        for (SplitOrderRequest request : requests) {
            try {
                SplitOrderDto splitDto = new SplitOrderDto();
                splitDto.orderId = request.orderId;
                splitDto.items = new List<SplitItemDto>();
                
                for (SplitOrderItem item : request.items) {
                    SplitItemDto itemDto = new SplitItemDto();
                    itemDto.orderItemId = item.sku;
                    itemDto.quantity = item.quantity;
                    splitDto.items.add(itemDto);
                }
                
                LacoreConnectService.ApiResponse response = LacoreConnectService.splitOrder(request.orderId, splitDto);
                responses.add(new SplitOrderResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class SplitOrderRequest {
        @InvocableVariable(required=true label='Order ID')
        public String orderId;
        
        @InvocableVariable(required=true label='Items to Split')
        public List<SplitOrderItem> items;
    }
    
    public class SplitOrderItem {
        @InvocableVariable(required=true label='SKU')
        public String sku;
        
        @InvocableVariable(required=true label='Quantity')
        public Integer quantity;
    }
    
    public class SplitOrderResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public SplitOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 