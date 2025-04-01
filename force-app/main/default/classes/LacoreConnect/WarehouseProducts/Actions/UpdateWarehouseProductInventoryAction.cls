public class UpdateWarehouseProductInventoryAction {
    @InvocableMethod(label='Update Warehouse Product Inventory' description='Updates the inventory for a warehouse product' category='Lacore Connect')
    public static List<UpdateWarehouseProductInventoryResponse> execute(List<UpdateWarehouseProductInventoryRequest> requests) {
        List<UpdateWarehouseProductInventoryResponse> responses = new List<UpdateWarehouseProductInventoryResponse>();
        
        for(UpdateWarehouseProductInventoryRequest request : requests) {
            try {
                // Call the service to update the warehouse product inventory
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.updateWarehouseProductInventory(request.inventory);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    UpdateWarehouseProductInventoryResponse response = new UpdateWarehouseProductInventoryResponse();
                    response.success = true;
                    response.data = (WarehouseProductInventoryDto)JSON.deserialize(apiResponse.body, WarehouseProductInventoryDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    UpdateWarehouseProductInventoryResponse response = new UpdateWarehouseProductInventoryResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                UpdateWarehouseProductInventoryResponse response = new UpdateWarehouseProductInventoryResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class UpdateWarehouseProductInventoryRequest {        
        @InvocableVariable
        public WarehouseProductInventoryDto inventory;
    }
    
    public class UpdateWarehouseProductInventoryResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public WarehouseProductInventoryDto data;
    }
} 