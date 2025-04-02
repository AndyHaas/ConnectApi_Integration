public class CreateASNAction {
    @InvocableMethod(label='Create ASN' description='Creates a new Advanced Shipping Notice (ASN).')
    public static List<CreateASNResponse> execute(List<CreateASNRequest> requests) {
        List<CreateASNResponse> responses = new List<CreateASNResponse>();
        
        for (CreateASNRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.createASN(request.shipment);
                
                responses.add(new CreateASNResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class CreateASNRequest {
        @InvocableVariable(required=true label='Shipment' description='The ASN shipment to create.')
        public WarehouseShipmentCreateReq shipment;
    }
    
    public class CreateASNResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipment' description='The created ASN shipment.')
        public WarehouseShipmentDto shipment;

        public CreateASNResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            this.shipment = (WarehouseShipmentDto) JSON.deserialize(response.body, WarehouseShipmentDto.class);
        }
    }
} 