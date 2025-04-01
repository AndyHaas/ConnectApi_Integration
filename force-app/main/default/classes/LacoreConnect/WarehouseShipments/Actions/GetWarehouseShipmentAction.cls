public class GetWarehouseShipmentAction {
    @InvocableMethod(label='Get Warehouse Shipment' description='Gets a single warehouse shipment by ID.')
    public static List<GetWarehouseShipmentResponse> execute(List<GetWarehouseShipmentRequest> requests) {
        List<GetWarehouseShipmentResponse> responses = new List<GetWarehouseShipmentResponse>();
        
        for (GetWarehouseShipmentRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.getWarehouseShipmentById(request.id);
                
                GetWarehouseShipmentResponse response = new GetWarehouseShipmentResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                GetWarehouseShipmentResponse response = new GetWarehouseShipmentResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseShipmentRequest {
        @InvocableVariable(required=true label='ID' description='ID of the warehouse shipment to retrieve.')
        public Integer id;
    }
    
    public class GetWarehouseShipmentResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The retrieved warehouse shipment.')
        public WarehouseShipmentDto shipment;
    }
} 