public class GetStorefrontProductsAction {
    @InvocableMethod(label='Get Storefront Products' description='Retrieves a list of storefront products' category='Lacore Connect')
    public static List<GetStorefrontProductsResponse> execute(List<GetStorefrontProductsRequest> requests) {
        List<GetStorefrontProductsResponse> responses = new List<GetStorefrontProductsResponse>();
        
        for(GetStorefrontProductsRequest request : requests) {
            try {
                // Call the service to get storefront products
                LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getStorefrontProducts(
                    request.storefrontId,
                    request.sku,
                    request.page,
                    request.pageSize,
                    request.sortDir
                );
                
                if (apiResponse.isSuccess) {
                    // Create successful response
                    GetStorefrontProductsResponse response = new GetStorefrontProductsResponse();
                    response.success = true;
                    response.data = (List<StorefrontProductDto>)JSON.deserialize(apiResponse.body, List<StorefrontProductDto>.class);
                    responses.add(response);
                } else {
                    // Create error response
                    GetStorefrontProductsResponse response = new GetStorefrontProductsResponse();
                    response.success = false;
                    response.message = apiResponse.errorMessage;
                    responses.add(response);
                }
            } catch(Exception e) {
                // Create error response
                GetStorefrontProductsResponse response = new GetStorefrontProductsResponse();
                response.success = false;
                response.message = e.getMessage();
                responses.add(response);
            }
        }
        
        return responses;
    }
    
    public class GetStorefrontProductsRequest {        
        @InvocableVariable(required=false label='Storefront ID' description='Filter products by storefront ID')
        public String storefrontId;
        
        @InvocableVariable(required=false label='SKU' description='Filter products by SKU')
        public String sku;
        
        @InvocableVariable(required=false label='Page' description='Page number for pagination')
        public Integer page;
        
        @InvocableVariable(required=false label='Page Size' description='Number of items per page')
        public Integer pageSize;
        
        @InvocableVariable(required=false label='Sort Direction' description='Sort direction (ASC or DESC)')
        public String sortDir;
    }
    
    public class GetStorefrontProductsResponse {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String message;
        @InvocableVariable public List<StorefrontProductDto> data;
    }
} 