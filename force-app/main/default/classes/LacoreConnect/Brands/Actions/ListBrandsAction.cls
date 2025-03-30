public class ListBrandsAction {
    @InvocableMethod(label='List Brands' description='Lists all brands with pagination' category='Lacore Connect')
    public static List<ListBrandsResponse> execute(List<ListBrandsRequest> requests) {
        List<ListBrandsResponse> responses = new List<ListBrandsResponse>();
        
        for (ListBrandsRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.listBrands(
                    request.page,
                    request.pageSize,
                    request.sortBy,
                    request.sortDir
                );
                responses.add(new ListBrandsResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class ListBrandsRequest {
        @InvocableVariable
        public Integer page;
        
        @InvocableVariable
        public Integer pageSize;
        
        @InvocableVariable
        public String sortBy;
        
        @InvocableVariable
        public String sortDir;
    }
    
    public class ListBrandsResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public ListBrandsResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 