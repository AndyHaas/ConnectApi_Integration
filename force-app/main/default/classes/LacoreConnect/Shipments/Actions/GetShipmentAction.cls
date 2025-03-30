public class GetShipmentAction {
    @InvocableMethod(label='Get Shipment' description='Gets a specific shipment from LacoreConnect' category='Lacore Connect')
    public static List<GetShipmentResponse> execute(List<GetShipmentRequest> requests) {
        List<GetShipmentResponse> responses = new List<GetShipmentResponse>();
        
        for (GetShipmentRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment(request.id);
                responses.add(new GetShipmentResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetShipmentRequest {
        @InvocableVariable(required=true)
        public String id;
    }
    
    public class GetShipmentResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public GetShipmentResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 