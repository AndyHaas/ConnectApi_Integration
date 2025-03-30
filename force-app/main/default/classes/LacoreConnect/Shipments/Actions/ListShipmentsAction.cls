public class ListShipmentsAction {
    @InvocableMethod(label='List Shipments' description='Lists shipments from LacoreConnect' category='Lacore Connect')
    public static List<ListShipmentsResponse> execute(List<ListShipmentsRequest> requests) {
        List<ListShipmentsResponse> responses = new List<ListShipmentsResponse>();
        
        for (ListShipmentsRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.listShipments(
                    request.brandId,
                    request.warehouseId,
                    request.status,
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                responses.add(new ListShipmentsResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class ListShipmentsRequest {
        @InvocableVariable(required=true)
        public String brandId;
        
        @InvocableVariable(required=true)
        public String warehouseId;
        
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
    
    public class ListShipmentsResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public ListShipmentsResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 