public class DeleteStorefrontProductAction {
    @InvocableMethod(label='Delete Storefront Product' description='Deletes an existing storefront product' category='Lacore Connect')
    public static List<DeleteStorefrontProductResponse> execute(List<DeleteStorefrontProductRequest> requests) {
        List<DeleteStorefrontProductResponse> responses = new List<DeleteStorefrontProductResponse>();
        
        for(DeleteStorefrontProductRequest request : requests) {
            try {
                // Call the service to delete storefront product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.deleteStorefrontProduct(request.productId);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    DeleteStorefrontProductResponse response = new DeleteStorefrontProductResponse();
                    response.success = true;
                    responses.add(response);
                } else {
                    // Create error response
                    DeleteStorefrontProductResponse response = new DeleteStorefrontProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                DeleteStorefrontProductResponse response = new DeleteStorefrontProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class DeleteStorefrontProductRequest {
        @InvocableVariable(required=true label='Product ID' description='The ID of the storefront product to delete')
        public String productId;
    }
    
    public class DeleteStorefrontProductResponse {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String message;
    }
} 