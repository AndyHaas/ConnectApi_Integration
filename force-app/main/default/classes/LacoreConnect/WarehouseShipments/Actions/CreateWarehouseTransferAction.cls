public class CreateWarehouseTransferAction {
    @InvocableMethod(label='Create Warehouse Transfer' description='Creates a new warehouse transfer shipment.')
    public static List<CreateWarehouseTransferResponse> execute(List<CreateWarehouseTransferRequest> requests) {
        List<CreateWarehouseTransferResponse> responses = new List<CreateWarehouseTransferResponse>();
        
        for (CreateWarehouseTransferRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.createWarehouseTransfer(request.shipment);
                
                CreateWarehouseTransferResponse response = new CreateWarehouseTransferResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                CreateWarehouseTransferResponse response = new CreateWarehouseTransferResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class CreateWarehouseTransferRequest {
        @InvocableVariable(required=true label='Shipment' description='The warehouse shipment to create.')
        public WarehouseShipmentCreateReq shipment;
    }
    
    public class CreateWarehouseTransferResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The created warehouse shipment.')
        public WarehouseShipmentDto shipment;
    }
} 