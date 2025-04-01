public class GetWarehouseProductInventoryAction {
    @InvocableMethod(label='Get Warehouse Product Inventory' description='Gets the inventory for a warehouse product' category='Lacore Connect')
    public static List<GetWarehouseProductInventoryResponse> execute(List<GetWarehouseProductInventoryRequest> requests) {
        List<GetWarehouseProductInventoryResponse> responses = new List<GetWarehouseProductInventoryResponse>();
        
        for(GetWarehouseProductInventoryRequest request : requests) {
            try {
                // Call the service to get the warehouse product inventory with query parameters
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getWarehouseProductInventoryByLocation(
                    request.item,
                    request.warehouseProductId,
                    request.warehouseId,
                    request.brandId,
                    request.lpn,
                    request.locationCode,
                    request.lotNumber,
                    request.page,
                    request.pageSize,
                    request.sortDir
                );
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetWarehouseProductInventoryResponse response = new GetWarehouseProductInventoryResponse();
                    response.success = true;
                    response.data = (WarehouseProductInventoryResponseDto)JSON.deserialize(apiResponse.body, WarehouseProductInventoryResponseDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetWarehouseProductInventoryResponse response = new GetWarehouseProductInventoryResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetWarehouseProductInventoryResponse response = new GetWarehouseProductInventoryResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetWarehouseProductInventoryRequest {
        @InvocableVariable
        public String item;
        
        @InvocableVariable
        public String warehouseProductId;
        
        @InvocableVariable
        public String warehouseId;
        
        @InvocableVariable
        public String brandId;
        
        @InvocableVariable
        public String lpn;
        
        @InvocableVariable
        public String locationCode;
        
        @InvocableVariable
        public String lotNumber;
        
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        @InvocableVariable
        public String sortDir;
    }
    
    public class GetWarehouseProductInventoryResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseProductInventoryResponseDto data;
    }
} 