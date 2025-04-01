public class CreateASNAction {
    @InvocableMethod(label='Create ASN' description='Creates a new Advanced Shipping Notice (ASN).')
    public static List<CreateASNResponse> execute(List<CreateASNRequest> requests) {
        List<CreateASNResponse> responses = new List<CreateASNResponse>();
        
        for (CreateASNRequest request : requests) {
            try {
                WarehouseShipmentDto apiResponse = LacoreConnectService.createASN(request.shipment);
                
                CreateASNResponse response = new CreateASNResponse();
                response.isSuccess = true;
                response.shipment = apiResponse;
                responses.add(response);
            } catch (Exception e) {
                CreateASNResponse response = new CreateASNResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
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
    }
} 