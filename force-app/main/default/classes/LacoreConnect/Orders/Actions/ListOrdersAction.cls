public class ListOrdersAction {
    @InvocableMethod(label='List Orders' description='Lists orders from LacoreConnect' category='Lacore Connect')
    public static List<ListOrdersResponse> execute(List<ListOrdersRequest> requests) {
        List<ListOrdersResponse> responses = new List<ListOrdersResponse>();
        
        for (ListOrdersRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.listOrders(
                    request.brandId,
                    request.customerId,
                    request.status,
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                responses.add(new ListOrdersResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class ListOrdersRequest {
        @InvocableVariable
        public String brandId;
        
        @InvocableVariable
        public String customerId;
        
        @InvocableVariable
        public String status;
        
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        @InvocableVariable
        public String sortBy;
        
        @InvocableVariable
        public String sortDir;
    }
    
    public class ListOrdersResponse {
        @InvocableVariable
        public Boolean isSuccess;
        
        @InvocableVariable
        public String errorMessage;
        
        @InvocableVariable
        public List<OrderDto> orders;
        
        @InvocableVariable
        public Integer total;
        
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        public ListOrdersResponse(LacoreConnectService.ApiResponse response) {
            this.isSuccess = response.isSuccess;
            this.errorMessage = response.errorMessage;
            if (response.isSuccess) {
                OrderListResponseDto listResponse = (OrderListResponseDto)JSON.deserialize(response.body, OrderListResponseDto.class);
                this.orders = listResponse.orders;
                this.total = listResponse.total;
                this.page = listResponse.page;
                this.pageSize = listResponse.pageSize;
            }
        }
    }
} 