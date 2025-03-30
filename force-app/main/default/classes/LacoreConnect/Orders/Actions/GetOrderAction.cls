public with sharing class GetOrderAction {
    @InvocableMethod(label='Get Order' description='Get order details from Lacore Connect' category='Lacore Connect')
    public static List<GetOrderResponse> execute(List<GetOrderRequest> requests) {
        List<GetOrderResponse> responses = new List<GetOrderResponse>();
        
        for (GetOrderRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.getOrder(request.orderId);
                responses.add(new GetOrderResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetOrderRequest {
        @InvocableVariable(required=true label='Order ID')
        public String orderId;
    }
    
    public class GetOrderResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public GetOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 