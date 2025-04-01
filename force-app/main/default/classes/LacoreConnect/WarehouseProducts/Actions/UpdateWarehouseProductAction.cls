public class UpdateWarehouseProductAction {
    @InvocableMethod(label='Update Warehouse Product' description='Updates an existing warehouse product' category='Lacore Connect')
    public static List<UpdateWarehouseProductResponse> execute(List<UpdateWarehouseProductRequest> requests) {
        List<UpdateWarehouseProductResponse> responses = new List<UpdateWarehouseProductResponse>();
        
        for(UpdateWarehouseProductRequest request : requests) {
            try {
                // Call the service to update the warehouse product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.updateWarehouseProduct(request.id, request.product);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    UpdateWarehouseProductResponse response = new UpdateWarehouseProductResponse();
                    response.success = true;
                    response.data = (WarehouseProductDto)JSON.deserialize(apiResponse.body, WarehouseProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    UpdateWarehouseProductResponse response = new UpdateWarehouseProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                UpdateWarehouseProductResponse response = new UpdateWarehouseProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class UpdateWarehouseProductRequest {
        @InvocableVariable
        public String id;
        
        @InvocableVariable
        public WarehouseProductDto product;
    }
    
    public class UpdateWarehouseProductResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseProductDto data;
    }
} 