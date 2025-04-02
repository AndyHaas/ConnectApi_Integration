public class ConfirmShipmentReceivedAction {
    @InvocableMethod(label='Confirm Shipment Received' description='Confirms that a shipment has been received.')
    public static List<ConfirmShipmentReceivedResponse> execute(List<ConfirmShipmentReceivedRequest> requests) {
        List<ConfirmShipmentReceivedResponse> responses = new List<ConfirmShipmentReceivedResponse>();
        
        for (ConfirmShipmentReceivedRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.confirmShipmentReceived(
                    request.id,
                    request.confirmation
                );
                
                responses.add(new ConfirmShipmentReceivedResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class ConfirmShipmentReceivedRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to confirm.')
        public String id;
        
        @InvocableVariable(required=true label='Confirmation' description='Confirmation details for the shipment.')
        public WarehouseShipmentConfirmReceivedReq confirmation;
    }
    
    public class ConfirmShipmentReceivedResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The updated warehouse shipment.')
        public WarehouseShipmentDto shipment;

        public ConfirmShipmentReceivedResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 