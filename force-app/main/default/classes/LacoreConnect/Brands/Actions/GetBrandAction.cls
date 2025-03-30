public class GetBrandAction {
    @InvocableMethod(label='Get Brand' description='Gets a brand by ID' category='Lacore Connect')
    public static List<GetBrandResponse> execute(List<GetBrandRequest> requests) {
        List<GetBrandResponse> responses = new List<GetBrandResponse>();
        
        for (GetBrandRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.getBrand(request.brandId);
                responses.add(new GetBrandResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetBrandRequest {
        @InvocableVariable(required=true)
        public String brandId;
    }
    
    public class GetBrandResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public GetBrandResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 