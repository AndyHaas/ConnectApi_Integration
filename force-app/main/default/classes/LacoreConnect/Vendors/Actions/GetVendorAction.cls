public class GetVendorAction {
    @InvocableMethod(label='Get Vendor' description='Gets a vendor by ID' category='Lacore Connect')
    public static List<GetVendorResponse> execute() {
        List<GetVendorResponse> responses = new List<GetVendorResponse>();
        
        try {
            // Call the service to get the vendor
            LacoreConnectService.ApiResponse apiResponse = LacoreConnectService.getVendors();
            
            if (apiResponse.isSuccess) {
                // Create successful response
                GetVendorResponse response = new GetVendorResponse();
                response.success = true;
                response.data = (VendorDto)JSON.deserialize(apiResponse.body, VendorDto.class);
                responses.add(response);
            } else {
                // Create error response
                GetVendorResponse response = new GetVendorResponse();
                response.success = false;
                response.message = apiResponse.errorMessage;
                responses.add(response);
            }
        } catch(Exception e) {
            // Create error response
            GetVendorResponse response = new GetVendorResponse();
            response.success = false;
            response.message = e.getMessage();
            responses.add(response);
        }
        
        return responses;
    }
    
    public class GetVendorResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public VendorDto data;
    }
} 