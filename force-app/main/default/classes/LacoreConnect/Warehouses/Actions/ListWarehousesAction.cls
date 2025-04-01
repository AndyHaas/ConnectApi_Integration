public class ListWarehousesAction {
    @InvocableMethod(label='List Warehouses' description='Gets a list of warehouses with pagination' category='Lacore Connect')
    public static List<ListWarehousesResponse> execute(List<ListWarehousesRequest> requests) {
        List<ListWarehousesResponse> responses = new List<ListWarehousesResponse>();
        
        for(ListWarehousesRequest request : requests) {
            try {
                // Call the service to get the list of warehouses
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.listWarehouses(
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    ListWarehousesResponse response = new ListWarehousesResponse();
                    response.success = true;
                    response.data = (WarehouseDtoPaginatedItemsResponse)JSON.deserialize(apiResponse.body, WarehouseDtoPaginatedItemsResponse.class);
                    responses.add(response);
                } else {
                    // Create error response
                    ListWarehousesResponse response = new ListWarehousesResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                ListWarehousesResponse response = new ListWarehousesResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class ListWarehousesRequest {
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        @InvocableVariable
        public String sortBy;
        
        @InvocableVariable
        public String sortDir;
    }
    
    public class ListWarehousesResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseDtoPaginatedItemsResponse data;
    }
} 