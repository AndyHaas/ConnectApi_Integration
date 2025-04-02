public class GetWarehouseShipmentAction {
    @InvocableMethod(label='Get Warehouse Shipment' description='Gets a single warehouse shipment by ID.')
    public static List<GetWarehouseShipmentResponse> execute(List<GetWarehouseShipmentRequest> requests) {
        List<GetWarehouseShipmentResponse> responses = new List<GetWarehouseShipmentResponse>();
        
        for (GetWarehouseShipmentRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getWarehouseShipmentById(request.id);
                
                responses.add(new GetWarehouseShipmentResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseShipmentRequest {
        @InvocableVariable(required=true label='ID' description='ID of the warehouse shipment to retrieve.')
        public String id;
    }
    
    public class GetWarehouseShipmentResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The retrieved warehouse shipment.')
        public WarehouseShipmentDto shipment;

        public GetWarehouseShipmentResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 