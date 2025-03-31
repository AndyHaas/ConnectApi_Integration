public class GetStorefrontsAction {
    @InvocableMethod(label='Get Storefronts' description='Retrieves a list of all storefronts' category='Lacore Connect')
    public static List<GetStorefrontsResponse> execute(List<GetStorefrontsRequest> requests) {
        List<GetStorefrontsResponse> responses = new List<GetStorefrontsResponse>();
        
        for(GetStorefrontsRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefronts(request.page, request.pageSize, request.sortDir);
                responses.add(new GetStorefrontsResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetStorefrontsRequest {
        @InvocableVariable(required=false label='Page' description='Page number for pagination')
        public Integer page;
        
        @InvocableVariable(required=false label='Page Size' description='Number of items per page')
        public Integer pageSize;
        
        @InvocableVariable(required=false label='Sort Direction' description='Sort direction (ASC or DESC)')
        public String sortDir;
    }

    public class GetStorefrontsResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
    
        @InvocableVariable
        public String data;
        
        public GetStorefrontsResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 