public class CancelShipmentAction {
    @InvocableMethod(label='Cancel Shipment' description='Cancels a warehouse shipment.')
    public static List<CancelShipmentResponse> execute(List<CancelShipmentRequest> requests) {
        List<CancelShipmentResponse> responses = new List<CancelShipmentResponse>();
        
        for (CancelShipmentRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.cancelShipment(
                    request.id,
                    request.cancelRequest
                );
                
                CancelShipmentResponse response = new CancelShipmentResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                CancelShipmentResponse response = new CancelShipmentResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class CancelShipmentRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to cancel.')
        public Integer id;
        
        @InvocableVariable(required=true label='Cancel Request' description='Cancel request details.')
        public WarehouseShipmentCancelReq cancelRequest;
    }
    
    public class CancelShipmentResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The updated warehouse shipment.')
        public WarehouseShipmentDto shipment;
    }
} 