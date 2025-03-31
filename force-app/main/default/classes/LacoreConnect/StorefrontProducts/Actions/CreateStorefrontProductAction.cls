public class CreateStorefrontProductAction {
    @InvocableMethod(label='Create Storefront Product' description='Creates a new storefront product' category='Lacore Connect')
    public static List<CreateStorefrontProductResponse> execute(List<CreateStorefrontProductRequest> requests) {
        List<CreateStorefrontProductResponse> responses = new List<CreateStorefrontProductResponse>();
        
        for(CreateStorefrontProductRequest request : requests) {
            try {
                // Call the service to create storefront product
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.createStorefrontProduct(request.data);
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    CreateStorefrontProductResponse response = new CreateStorefrontProductResponse();
                    response.success = true;
                    response.data = (StorefrontProductDto)JSON.deserialize(apiResponse.body, StorefrontProductDto.class);
                    responses.add(response);
                } else {
                    // Create error response
                    CreateStorefrontProductResponse response = new CreateStorefrontProductResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                CreateStorefrontProductResponse response = new CreateStorefrontProductResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class CreateStorefrontProductRequest {
        @InvocableVariable(required=true label='Product Data' description='The storefront product data to create')
        public StorefrontProductDto data;
    }
    
    public class CreateStorefrontProductResponse {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String message;
        @InvocableVariable public StorefrontProductDto data;
    }
} 