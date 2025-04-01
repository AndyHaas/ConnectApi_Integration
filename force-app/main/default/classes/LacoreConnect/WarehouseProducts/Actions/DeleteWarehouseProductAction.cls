public class DeleteWarehouseProductAction {
    @InvocableMethod(label='Delete Warehouse Product' description='Deletes a warehouse product' category='Lacore Connect')
    public static List<DeleteWarehouseProductResponse> execute(List<DeleteWarehouseProductRequest> requests) {
        List<DeleteWarehouseProductResponse> responses = new List<DeleteWarehouseProductResponse>();
        
        for(DeleteWarehouseProductRequest request : requests) {
            try {
                // Call the service to delete the warehouse product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.deleteWarehouseProduct(request.id);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    DeleteWarehouseProductResponse response = new DeleteWarehouseProductResponse();
                    response.success = true;
                    responses.add(response);
                } else {
                    // Create error response
                    DeleteWarehouseProductResponse response = new DeleteWarehouseProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                DeleteWarehouseProductResponse response = new DeleteWarehouseProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class DeleteWarehouseProductRequest {
        @InvocableVariable
        public String id;
    }
    
    public class DeleteWarehouseProductResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
    }
} 