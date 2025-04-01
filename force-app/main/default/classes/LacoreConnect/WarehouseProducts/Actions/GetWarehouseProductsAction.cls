public class GetWarehouseProductsAction {
    @InvocableMethod(label='Get Warehouse Products' description='Gets a list of warehouse products' category='Lacore Connect')
    public static List<GetWarehouseProductsResponse> execute(List<GetWarehouseProductsRequest> requests) {
        List<GetWarehouseProductsResponse> responses = new List<GetWarehouseProductsResponse>();
        
        for(GetWarehouseProductsRequest request : requests) {
            try {
                // Call the service to get the warehouse products
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getWarehouseProducts(
                    request.warehouseId,
                    request.sku,
                    request.page,
                    request.pageSize,
                    request.sortDir
                );
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetWarehouseProductsResponse response = new GetWarehouseProductsResponse();
                    response.success = true;
                    response.data = (List<WarehouseProductDto>)JSON.deserialize(apiResponse.body, List<WarehouseProductDto>.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetWarehouseProductsResponse response = new GetWarehouseProductsResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetWarehouseProductsResponse response = new GetWarehouseProductsResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseProductsRequest {
        @InvocableVariable
        public String warehouseId;
        
        @InvocableVariable
        public String sku;
        
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        @InvocableVariable
        public String sortDir;
    }
    
    public class GetWarehouseProductsResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public List<WarehouseProductDto> data;
    }
} 