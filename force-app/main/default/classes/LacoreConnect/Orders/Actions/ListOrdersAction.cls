/**
 * @description Action class for listing orders in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to retrieve a list of orders based on specified criteria.
 */
public with sharing class ListOrdersAction {
    /**
     * @description Invocable method to list orders in LacoreConnect
     * @param requests List of ListOrdersRequest objects containing search criteria
     * @return List<ListOrdersResponse> List of responses containing order data
     */
    @InvocableMethod(label='List Orders' description='Retrieve a list of orders from Lacore Connect' category='Lacore Connect')
    public static List<ListOrdersResponse> execute(List<ListOrdersRequest> requests) {
        List<ListOrdersResponse> responses = new List<ListOrdersResponse>();
        
        for (ListOrdersRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.listOrders(
                    request.storefrontId,
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir,
                    request.createdDateStart,
                    request.createdDateEnd,
                    request.orderDateStart,
                    request.orderDateEnd,
                    request.orderNumber,
                    request.orderStatus
                    
                );
                responses.add(new ListOrdersResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    /**
     * @description Request class for the ListOrders action
     */
    public class ListOrdersRequest {
        /** The storefront ID to filter orders by */
        @InvocableVariable(required=true label='Storefront ID')
        public String storefrontId;
        
        @InvocableVariable(required=false label='Sort By (createDate, orderDate, modifyDate)')
        public String sortBy;
        
        @InvocableVariable(required=false label='Sort Direction (asc, desc)')
        public String sortDir;
        
        @InvocableVariable(required=false label='Start Date')
        public Date createdDateStart;
        
        @InvocableVariable(required=false label='End Date')
        public Date createdDateEnd;
        
        @InvocableVariable(required=false label='Start Date')
        public Date orderDateStart;
        
        @InvocableVariable(required=false label='End Date')
        public Date orderDateEnd;
        
        @InvocableVariable(required=false label='Order Number')
        public String orderNumber;
        
        @InvocableVariable(required=false label='Order Status')
        public String orderStatus;

        @InvocableVariable(required=false label='Page')
        public Integer page;

        @InvocableVariable(required=false label='Page Size')
        public Integer pageSize;
    }
    
     /**
     * @description Response class for the ListOrders action
     */
    public class ListOrdersResponse {
        /** Whether the request was successful */
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