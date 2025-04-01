public class CreateWarehouseProductAction {
    @InvocableMethod(label='Create Warehouse Product' description='Creates a new warehouse product' category='Lacore Connect')
    public static List<CreateWarehouseProductResponse> execute(List<CreateWarehouseProductRequest> requests) {
        List<CreateWarehouseProductResponse> responses = new List<CreateWarehouseProductResponse>();
        
        for(CreateWarehouseProductRequest request : requests) {
            try {
                // Call the service to create the warehouse product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.createWarehouseProduct(request.product);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    CreateWarehouseProductResponse response = new CreateWarehouseProductResponse();
                    response.success = true;
                    response.data = (WarehouseProductDto)JSON.deserialize(apiResponse.body, WarehouseProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    CreateWarehouseProductResponse response = new CreateWarehouseProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                CreateWarehouseProductResponse response = new CreateWarehouseProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class CreateWarehouseProductRequest {
        @InvocableVariable
        public WarehouseProductDto product;
    }
    
    public class CreateWarehouseProductResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseProductDto data;
    }
} 