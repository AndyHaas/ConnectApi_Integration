public class GetWarehouseAction {
    @InvocableMethod(label='Get Warehouse By ID' description='Gets a specific warehouse by ID' category='Lacore Connect')
    public static List<GetWarehouseResponse> execute(List<GetWarehouseRequest> requests) {
        List<GetWarehouseResponse> responses = new List<GetWarehouseResponse>();
        
        for(GetWarehouseRequest request : requests) {
            try {
                // Call the service to get the warehouse
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getWarehouseById(request.id);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetWarehouseResponse response = new GetWarehouseResponse();
                    response.success = true;
                    response.data = (WarehouseDto)JSON.deserialize(apiResponse.body, WarehouseDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetWarehouseResponse response = new GetWarehouseResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetWarehouseResponse response = new GetWarehouseResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseRequest {
        @InvocableVariable
        public String id;
    }
    
    public class GetWarehouseResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseDto data;
    }
} 