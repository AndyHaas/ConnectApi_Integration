public class ConfirmShipmentReceivedAction {
    @InvocableMethod(label='Confirm Shipment Received' description='Confirms that a shipment has been received.')
    public static List<ConfirmShipmentReceivedResponse> execute(List<ConfirmShipmentReceivedRequest> requests) {
        List<ConfirmShipmentReceivedResponse> responses = new List<ConfirmShipmentReceivedResponse>();
        
        for (ConfirmShipmentReceivedRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.confirmShipmentReceived(
                    request.id,
                    request.confirmation
                );
                
                ConfirmShipmentReceivedResponse response = new ConfirmShipmentReceivedResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                ConfirmShipmentReceivedResponse response = new ConfirmShipmentReceivedResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class ConfirmShipmentReceivedRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to confirm.')
        public Integer id;
        
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
    }
} 