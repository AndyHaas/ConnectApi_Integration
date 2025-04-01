public class DeleteWarehouseAction {
    @InvocableMethod(label='Delete Warehouse By ID' description='Deletes a warehouse by ID' category='Lacore Connect')
    public static List<DeleteWarehouseResponse> execute(List<DeleteWarehouseRequest> requests) {
        List<DeleteWarehouseResponse> responses = new List<DeleteWarehouseResponse>();
        
        for(DeleteWarehouseRequest request : requests) {
            try {
                // Call the service to delete the warehouse
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.deleteWarehouse(request.warehouseId);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    DeleteWarehouseResponse response = new DeleteWarehouseResponse();
                    response.success = true;
                    response.message = 'Warehouse deleted successfully';
                    responses.add(response);
                } else {
                    // Create error response
                    DeleteWarehouseResponse response = new DeleteWarehouseResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                DeleteWarehouseResponse response = new DeleteWarehouseResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class DeleteWarehouseRequest {
        @InvocableVariable
        public String warehouseId;
    }
    
    public class DeleteWarehouseResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
    }
} 