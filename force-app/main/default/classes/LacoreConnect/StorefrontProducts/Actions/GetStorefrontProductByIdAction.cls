public class GetStorefrontProductByIdAction {
    @InvocableMethod(label='Get Storefront Product by ID' description='Retrieves a single storefront product by ID' category='Lacore Connect')
    public static List<GetStorefrontProductByIdResponse> execute(List<GetStorefrontProductByIdRequest> requests) {
        List<GetStorefrontProductByIdResponse> responses = new List<GetStorefrontProductByIdResponse>();
        
        for(GetStorefrontProductByIdRequest request : requests) {
            try {
                // Call the service to get storefront product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getStorefrontProductById(request.productId);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetStorefrontProductByIdResponse response = new GetStorefrontProductByIdResponse();
                    response.success = true;
                    response.data = (StorefrontProductDto)JSON.deserialize(apiResponse.body, StorefrontProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetStorefrontProductByIdResponse response = new GetStorefrontProductByIdResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetStorefrontProductByIdResponse response = new GetStorefrontProductByIdResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetStorefrontProductByIdRequest {
        @InvocableVariable(required=true label='Product ID' description='The ID of the storefront product to retrieve')
        public String productId;
    }
    
    public class GetStorefrontProductByIdResponse {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String message;
        @InvocableVariable public StorefrontProductDto data;
    }
} 