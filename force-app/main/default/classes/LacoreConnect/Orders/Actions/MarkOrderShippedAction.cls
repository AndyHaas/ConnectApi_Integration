public class MarkOrderShippedAction {
    @InvocableMethod(label='Mark Order Shipped' description='Marks an order as shipped with tracking information' category='Lacore Connect')
    public static List<MarkOrderShippedResponse> execute(List<MarkOrderShippedRequest> requests) {
        List<MarkOrderShippedResponse> responses = new List<MarkOrderShippedResponse>();
        
        for (MarkOrderShippedRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.markOrderShipped(
                    request.orderId,
                    request.trackingNumber,
                    request.carrier
                );
                responses.add(new MarkOrderShippedResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class MarkOrderShippedRequest {
        @InvocableVariable(required=true)
        public String orderId;
        
        @InvocableVariable(required=true)
        public String trackingNumber;
        
        @InvocableVariable(required=true)
        public String carrier;
    }
    
    public class MarkOrderShippedResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public MarkOrderShippedResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 