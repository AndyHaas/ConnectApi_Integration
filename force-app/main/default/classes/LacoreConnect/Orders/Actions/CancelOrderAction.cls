public class CancelOrderAction {
    @InvocableMethod(label='Cancel Order' description='Cancels an order by ID' category='Lacore Connect')
    public static List<CancelOrderResponse> execute(List<CancelOrderRequest> requests) {
        List<CancelOrderResponse> responses = new List<CancelOrderResponse>();
        
        for (CancelOrderRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.cancelOrder(request.orderId);
                responses.add(new CancelOrderResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class CancelOrderRequest {
        @InvocableVariable(required=true)
        public String orderId;
    }
    
    public class CancelOrderResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public CancelOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 