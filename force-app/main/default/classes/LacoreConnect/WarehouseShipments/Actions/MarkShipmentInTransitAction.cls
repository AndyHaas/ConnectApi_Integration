public class MarkShipmentInTransitAction {
    @InvocableMethod(label='Mark Shipment In Transit' description='Marks a shipment as in transit.')
    public static List<MarkShipmentInTransitResponse> execute(List<MarkShipmentInTransitRequest> requests) {
        List<MarkShipmentInTransitResponse> responses = new List<MarkShipmentInTransitResponse>();
        
        for (MarkShipmentInTransitRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.markShipmentInTransit(
                    request.id,
                    request.transitRequest
                );
                
                MarkShipmentInTransitResponse response = new MarkShipmentInTransitResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                MarkShipmentInTransitResponse response = new MarkShipmentInTransitResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class MarkShipmentInTransitRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to mark as in transit.')
        public Integer id;
        
        @InvocableVariable(required=true label='Transit Request' description='Transit request details.')
        public WarehouseShipmentMarkInTransitReq transitRequest;
    }
    
    public class MarkShipmentInTransitResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The updated warehouse shipment.')
        public WarehouseShipmentDto shipment;
    }
} 