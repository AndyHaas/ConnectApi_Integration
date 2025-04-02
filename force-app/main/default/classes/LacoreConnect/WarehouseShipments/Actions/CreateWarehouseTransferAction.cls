public class CreateWarehouseTransferAction {
    @InvocableMethod(label='Create Warehouse Transfer' description='Creates a new warehouse transfer shipment.')
    public static List<CreateWarehouseTransferResponse> execute(List<CreateWarehouseTransferRequest> requests) {
        List<CreateWarehouseTransferResponse> responses = new List<CreateWarehouseTransferResponse>();
        
        for (CreateWarehouseTransferRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.createWarehouseTransfer(request.shipment);
                
                responses.add(new CreateWarehouseTransferResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
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

        public CreateWarehouseTransferResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 