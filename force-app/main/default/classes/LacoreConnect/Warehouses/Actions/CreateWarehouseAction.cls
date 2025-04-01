public class CreateWarehouseAction {
    @InvocableMethod(label='Create Warehouse' description='Creates a new warehouse' category='Lacore Connect')
    public static List<CreateWarehouseResponse> execute(List<CreateWarehouseRequest> requests) {
        List<CreateWarehouseResponse> responses = new List<CreateWarehouseResponse>();
        
        for(CreateWarehouseRequest request : requests) {
            try {
                // Call the service to create the warehouse
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.createWarehouse(request.data);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    CreateWarehouseResponse response = new CreateWarehouseResponse();
                    response.success = true;
                    response.data = (WarehouseDto)JSON.deserialize(apiResponse.body, WarehouseDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    CreateWarehouseResponse response = new CreateWarehouseResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                CreateWarehouseResponse response = new CreateWarehouseResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class CreateWarehouseRequest {
        @InvocableVariable
        public WarehouseDto data;
    }
    
    public class CreateWarehouseResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseDto data;
    }
} 