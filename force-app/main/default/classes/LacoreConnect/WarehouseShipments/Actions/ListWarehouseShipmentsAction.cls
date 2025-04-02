public class ListWarehouseShipmentsAction {
    @InvocableMethod(label='List Warehouse Shipments' description='Lists warehouse shipments with pagination and sorting.')
    public static List<ListWarehouseShipmentsResponse> execute(List<ListWarehouseShipmentsRequest> requests) {
        List<ListWarehouseShipmentsResponse> responses = new List<ListWarehouseShipmentsResponse>();
        
        for (ListWarehouseShipmentsRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.listWarehouseShipments(
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                
                responses.add(new ListWarehouseShipmentsResponse(apiResponse));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
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
        @InvocableVariable
        public Boolean isSuccess;
        
        @InvocableVariable
        public String errorMessage;
        
        @InvocableVariable
        public List<WarehouseShipmentDto> items;
        
        @InvocableVariable
        public Integer perPage;
        
        @InvocableVariable
        public Integer total;
        
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer totalPages;

        public ListWarehouseShipmentsResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            
            if (response.isSuccess && response.body != null) {
                PaginatedResponseDto paginatedResponse = (PaginatedResponseDto) JSON.deserialize(response.body, PaginatedResponseDto.class);
                this.items = (List<WarehouseShipmentDto>) JSON.deserialize(JSON.serialize(paginatedResponse.items), List<WarehouseShipmentDto>.class);
                this.perPage = paginatedResponse.perPage;
                this.total = paginatedResponse.total;
                this.page = paginatedResponse.page;
                this.totalPages = paginatedResponse.totalPages;
            }
        }       
    }
} 