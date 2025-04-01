public class ListWarehouseShipmentsAction {
    @InvocableMethod(label='List Warehouse Shipments' description='Lists warehouse shipments with pagination and sorting.')
    public static List<ListWarehouseShipmentsResponse> execute(List<ListWarehouseShipmentsRequest> requests) {
        List<ListWarehouseShipmentsResponse> responses = new List<ListWarehouseShipmentsResponse>();
        
        for (ListWarehouseShipmentsRequest request : requests) {
            try {
                WarehouseShipmentDtoPaginatedItemsResponse apiResponse = LacoreConnectService.listWarehouseShipments(
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                
                ListWarehouseShipmentsResponse response = new ListWarehouseShipmentsResponse();
                response.isSuccess = true;
                response.shipments = apiResponse.items;
                response.perPage = apiResponse.perPage;
                response.total = apiResponse.total;
                response.page = apiResponse.page;
                response.totalPages = apiResponse.totalPages;
                responses.add(response);
            } catch (Exception e) {
                ListWarehouseShipmentsResponse response = new ListWarehouseShipmentsResponse();
                response.isSuccess = false;
                response.errorMessage = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class ListWarehouseShipmentsRequest {
        @InvocableVariable(required=true label='Page' description='Page number for pagination.')
        public Integer page;
        
        @InvocableVariable(required=true label='Page Size' description='Number of items per page.')
        public Integer pageSize;
        
        @InvocableVariable(required=false label='Sort By' description='Field to sort by.')
        public String sortBy;
        
        @InvocableVariable(required=false label='Sort Direction' description='Sort direction (asc/desc).')
        public String sortDir;
    }
    
    public class ListWarehouseShipmentsResponse {
        @InvocableVariable(required=false label='Is Success' description='Whether the operation was successful.')
        public Boolean isSuccess;
        
        @InvocableVariable(required=false label='Error Message' description='Error message if operation failed.')
        public String errorMessage;
        
        @InvocableVariable(required=false label='Shipments' description='List of warehouse shipments.')
        public List<WarehouseShipmentDto> shipments;
        
        @InvocableVariable(required=false label='Per Page' description='Number of items per page.')
        public Integer perPage;
        
        @InvocableVariable(required=false label='Total' description='Total number of items.')
        public Integer total;
        
        @InvocableVariable(required=false label='Page' description='Current page number.')
        public Integer page;
        
        @InvocableVariable(required=false label='Total Pages' description='Total number of pages.')
        public Integer totalPages;
    }
} 