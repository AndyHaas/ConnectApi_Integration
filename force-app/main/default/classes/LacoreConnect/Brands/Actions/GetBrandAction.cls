public class GetBrandAction {
    @InvocableMethod(label='Get Brand' description='Gets a brand by ID' category='Lacore Connect')
    public static List<GetBrandResponse> execute() {        
        List<GetBrandResponse> responses = new List<GetBrandResponse>();
        
        try {
            // Call the service to get the brand
            LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getBrand();
            
            if (apiResponse.isSuccess) {
                // Create successful response
                GetBrandResponse response = new GetBrandResponse();
                response.success = true;
                response.data = (BrandDto)JSON.deserialize(apiResponse.body, BrandDto.class);
                responses.add(response);
            } else {
                // Create error response
                GetBrandResponse response = new GetBrandResponse();
                response.success = false;
                response.message = apiResponse.errorMessage;
                responses.add(response);
            }
        } catch(Exception e) {
            // Create error response
            GetBrandResponse response = new GetBrandResponse();
            response.success = false;
            response.message = e.getMessage();
            responses.add(response);
        }
        
        return responses;
    }

    public class GetBrandResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
    
        @InvocableVariable
        public BrandDto data;
    }
} 