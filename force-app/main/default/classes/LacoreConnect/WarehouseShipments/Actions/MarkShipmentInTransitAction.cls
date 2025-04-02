public class MarkShipmentInTransitAction {
    @InvocableMethod(label='Mark Shipment In Transit' description='Marks a shipment as in transit.')
    public static List<MarkShipmentInTransitResponse> execute(List<MarkShipmentInTransitRequest> requests) {
        List<MarkShipmentInTransitResponse> responses = new List<MarkShipmentInTransitResponse>();
        
        for (MarkShipmentInTransitRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.markShipmentInTransit(
                    request.id
                );

                responses.add(new MarkShipmentInTransitResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class MarkShipmentInTransitRequest {
        @InvocableVariable(required=true label='ID' description='ID of the shipment to mark as in transit.')
        public String id;
    }
    
    public class MarkShipmentInTransitResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The updated warehouse shipment.')
        public WarehouseShipmentDto shipment;

        public MarkShipmentInTransitResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 