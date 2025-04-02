/**
 * @description Action class for retrieving brand details in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to get detailed information about a specific brand.
 */
public with sharing class GetBrandAction {
    /**
     * @description Invocable method to get brand details in LacoreConnect
     * @param requests List of GetBrandRequest objects containing brand IDs
     * @return List<GetBrandResponse> List of responses containing brand details
     */
    @InvocableMethod(label='Get Brand' description='Retrieve brand details from Lacore Connect' category='Lacore Connect')
    public static List<GetBrandResponse> execute() {
        List<GetBrandResponse> responses = new List<GetBrandResponse>();
        
        try {
            LacoreConnectService.ApiResponse response = LacoreConnectService.getBrand();
            responses.add(new GetBrandResponse(response));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
        return responses;
    }
    
    /**
     * @description Response class for the GetBrand action
     */
    @TestVisible
    public class GetBrandResponse {
        /** Whether the request was successful */
        @InvocableVariable
        @AuraEnabled
        public Boolean success;
        
        /** Error message if the request failed */
        @InvocableVariable
        @AuraEnabled
        public String message;
        
        /** The brand data in JSON format */
        @InvocableVariable
        @AuraEnabled
        public BrandDto data;
        
        /**
         * @description Constructor that creates a response from an API response
         * @param response The API response from LacoreConnectService
         */
        public GetBrandResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = (BrandDto)JSON.deserialize(response.body, BrandDto.class);
        }
    }
} 