public class GetWarehouseProductByIdAction {
    @InvocableMethod(label='Get Warehouse Product by ID' description='Gets a warehouse product by ID' category='Lacore Connect')
    public static List<GetWarehouseProductByIdResponse> execute(List<GetWarehouseProductByIdRequest> requests) {
        List<GetWarehouseProductByIdResponse> responses = new List<GetWarehouseProductByIdResponse>();
        
        for(GetWarehouseProductByIdRequest request : requests) {
            try {
                // Call the service to get the warehouse product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getWarehouseProductById(request.id);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetWarehouseProductByIdResponse response = new GetWarehouseProductByIdResponse();
                    response.success = true;
                    response.data = (WarehouseProductDto)JSON.deserialize(apiResponse.body, WarehouseProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetWarehouseProductByIdResponse response = new GetWarehouseProductByIdResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetWarehouseProductByIdResponse response = new GetWarehouseProductByIdResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseProductByIdRequest {
        @InvocableVariable
        public String id;
    }
    
    public class GetWarehouseProductByIdResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseProductDto data;
    }
} 