/**
 * @description Action class for retrieving statistics in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to get various statistics and metrics about orders, customers, and other data.
 */
public with sharing class GetStatisticsAction {
    /**
     * @description Invocable method to get statistics in LacoreConnect
     * @param requests List of GetStatisticsRequest objects containing statistics parameters
     * @return List<GetStatisticsResponse> List of responses containing statistics data
     */
    @InvocableMethod(label='Get Statistics' description='Retrieve statistics from Lacore Connect' category='Lacore Connect')
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
    
    /**
     * @description Request class for the GetStatistics action
     */
    public class GetStatisticsRequest {
        /** The statistics request parameters */
        @InvocableVariable(required=true)
        public StatisticsRequestDto request;
    }
    
    /**
     * @description Response class for the GetStatistics action
     */
    public class GetStatisticsResponse {
        /** Whether the request was successful */
        @InvocableVariable
        public Boolean success;
        
        /** Error message if the request failed */
        @InvocableVariable
        public String message;
        
        /** The statistics data in JSON format */
        @InvocableVariable
        public StatisticsResponseDto data;
        
        /**
         * @description Constructor that creates a response from an API response
         * @param response The API response from LacoreConnectService
         */
        public GetStatisticsResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = (StatisticsResponseDto) JSON.deserialize(response.body, StatisticsResponseDto.class);
        }
    }
} 