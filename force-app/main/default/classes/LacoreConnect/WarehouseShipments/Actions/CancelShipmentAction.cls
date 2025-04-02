/**
 * @description Action to cancel a warehouse shipment
 */
public class CancelShipmentAction {
    /**
     * @description Invocable method to cancel a warehouse shipment
     * @param requests List of CancelShipmentRequest objects
     * @return List of CancelShipmentResponse objects
     */
    @InvocableMethod(label='Cancel Shipment' description='Cancels a warehouse shipment.' category='Lacore Connect')
    public static List<CancelShipmentResponse> execute(List<CancelShipmentRequest> requests) {
        List<CancelShipmentResponse> responses = new List<CancelShipmentResponse>();
        
        for (CancelShipmentRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.cancelShipment(
                    request.id
                );
                
                responses.add(new CancelShipmentResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class CancelShipmentRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to cancel.')
        public String id;
        
        @InvocableVariable(required=true label='Cancel Request' description='Cancel request details.')
        public WarehouseShipmentCancelReq cancelRequest;
    }
    
    public class CancelShipmentResponse {
        @InvocableVariable
        public Boolean isSuccess;
        
        @InvocableVariable
        public String errorMessage;
        
        @InvocableVariable
        public WarehouseShipmentDto shipment;

        public CancelShipmentResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 