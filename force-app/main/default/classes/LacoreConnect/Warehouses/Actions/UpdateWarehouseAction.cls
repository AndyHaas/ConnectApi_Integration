public class UpdateWarehouseAction {
    @InvocableMethod(label='Update Warehouse' description='Updates an existing warehouse' category='Lacore Connect')
    public static List<UpdateWarehouseResponse> execute(List<UpdateWarehouseRequest> requests) {
        List<UpdateWarehouseResponse> responses = new List<UpdateWarehouseResponse>();
        
        for(UpdateWarehouseRequest request : requests) {
            try {
                // Call the service to update the warehouse
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.updateWarehouse(request.data);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    UpdateWarehouseResponse response = new UpdateWarehouseResponse();
                    response.success = true;
                    response.data = (WarehouseDto)JSON.deserialize(apiResponse.body, WarehouseDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    UpdateWarehouseResponse response = new UpdateWarehouseResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                UpdateWarehouseResponse response = new UpdateWarehouseResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class UpdateWarehouseRequest {
        @InvocableVariable
        public WarehouseDto data;
    }
    
    public class UpdateWarehouseResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseDto data;
    }
} 