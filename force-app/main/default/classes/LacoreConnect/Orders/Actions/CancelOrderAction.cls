/**
 * @description Action class for canceling orders in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to cancel one or more orders.
 */
public with sharing class CancelOrderAction {
    /**
     * @description Invocable method to cancel orders in LacoreConnect
     * @param requests List of CancelOrderRequest objects containing order IDs to cancel
     * @return List<CancelOrderResponse> List of responses containing operation results
     */
    @InvocableMethod(label='Cancel Order' description='Cancel one order in Lacore Connect' category='Lacore Connect')
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
    
    /**
     * @description Request class for the CancelOrder action
     */
    public class CancelOrderRequest {        
        /** Single order ID for non-bulk operations */
        @InvocableVariable(label='Order ID')
        public String orderId;
    }
    
    /**
     * @description Response class for the CancelOrder action
     */
    public class CancelOrderResponse {
        /** Whether the request was successful */
        @InvocableVariable
        public Boolean success;
        
        /** Error message if the request failed */
        @InvocableVariable
        public String message;
        
        /** The order data in JSON format */
        @InvocableVariable
        public OrderDto data;
        
        /**
         * @description Constructor that creates a response from an API response
         * @param response The API response from LacoreConnectService
         */
        public CancelOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = (OrderDto)JSON.deserialize(response.body, OrderDto.class);
        }
    }
} 