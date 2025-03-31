public class GetStorefrontByIdAction {
    @InvocableMethod(label='Get Storefront By ID' description='Retrieves a storefront by its ID' category='Lacore Connect')
    public static List<GetStorefrontByIdResponse> execute(List<GetStorefrontByIdRequest> requests) {
        List<GetStorefrontByIdResponse> responses = new List<GetStorefrontByIdResponse>();
        
        for(GetStorefrontByIdRequest request : requests) {
            try {
                // Call the service to get the storefront
                LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefrontById(request.id);
                responses.add(new GetStorefrontByIdResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetStorefrontByIdRequest {
        @InvocableVariable(required=true label='Storefront ID' description='The ID of the storefront to retrieve')
        public String id;
    }

    public class GetStorefrontByIdResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public GetStorefrontByIdResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
    
} 