/**
 * @description Action class for retrieving order details in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to get detailed information about a specific order.
 */
public with sharing class GetOrderAction {
    /**
     * @description Invocable method to get order details in LacoreConnect
     * @param requests List of GetOrderRequest objects containing order IDs
     * @return List<GetOrderResponse> List of responses containing order details
     */
    @InvocableMethod(label='Get Order' description='Retrieve order details from Lacore Connect' category='Lacore Connect')
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
    
    /**
     * @description Request class for the GetOrder action
     */
    public class GetOrderRequest {
        /** The ID of the order to retrieve */
        @InvocableVariable(required=true label='Order ID')
        public String orderId;
    }
    
    /**
     * @description Response class for the GetOrder action
     */
    public class GetOrderResponse {
        /** Whether the request was successful */
        @InvocableVariable
        public Boolean success;
        
        /** Error message if the request failed */
        @InvocableVariable
        public String message;
        
        /** The order data in JSON format */
        @InvocableVariable
        public String data;
        
        /**
         * @description Constructor that creates a response from an API response
         * @param response The API response from LacoreConnectService
         */
        public GetOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 