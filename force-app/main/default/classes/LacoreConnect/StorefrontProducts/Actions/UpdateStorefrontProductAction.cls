public class UpdateStorefrontProductAction {
    @InvocableMethod(label='Update Storefront Product' description='Updates an existing storefront product' category='Lacore Connect')
    public static List<UpdateStorefrontProductResponse> execute(List<UpdateStorefrontProductRequest> requests) {
        List<UpdateStorefrontProductResponse> responses = new List<UpdateStorefrontProductResponse>();
        
        for(UpdateStorefrontProductRequest request : requests) {
            try {
                // Call the service to update storefront product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.updateStorefrontProduct(request.productId, request.data);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    UpdateStorefrontProductResponse response = new UpdateStorefrontProductResponse();
                    response.success = true;
                    response.data = (StorefrontProductDto)JSON.deserialize(apiResponse.body, StorefrontProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    UpdateStorefrontProductResponse response = new UpdateStorefrontProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                UpdateStorefrontProductResponse response = new UpdateStorefrontProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class UpdateStorefrontProductRequest {
        @InvocableVariable(required=true label='Product ID' description='The ID of the storefront product to update')
        public String productId;
        
        @InvocableVariable(required=true label='Product Data' description='The updated storefront product data')
        public StorefrontProductDto data;
    }
    
    public class UpdateStorefrontProductResponse {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String message;
        @InvocableVariable public StorefrontProductDto data;
    }
} 