public class GetStatisticsAction {
    @InvocableMethod(label='Get Statistics' description='Gets statistics from LacoreConnect' category='Lacore Connect')
    public static List<GetStatisticsResponse> execute(List<GetStatisticsRequest> requests) {
        List<GetStatisticsResponse> responses = new List<GetStatisticsResponse>();
        
        for (GetStatisticsRequest request : requests) {
            try {
                LacoreConnectService.ApiResponse response = LacoreConnectService.getProductStatistics(request.request);
                responses.add(new GetStatisticsResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class GetStatisticsRequest {
        @InvocableVariable(required=true)
        public StatisticsRequestDto request;
    }
    
    public class GetStatisticsResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public GetStatisticsResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
    
} 