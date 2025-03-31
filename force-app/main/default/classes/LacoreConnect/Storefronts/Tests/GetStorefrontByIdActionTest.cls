@IsTest
private class GetStorefrontByIdActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testGetStorefrontById() {
        // Create test request
        GetStorefrontByIdAction.GetStorefrontByIdRequest request = new GetStorefrontByIdAction.GetStorefrontByIdRequest();
        request.id = 'test-id-1';
        
        // Create test response
        StorefrontDto mockStorefront = new StorefrontDto();
        mockStorefront.id = 'test-id-1';
        mockStorefront.name = 'Test Storefront';
        mockStorefront.description = 'Test Description';
        mockStorefront.status = 'ACTIVE';
        String mockResponse = JSON.serialize(mockStorefront);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<GetStorefrontByIdAction.GetStorefrontByIdResponse> responses = GetStorefrontByIdAction.execute(new List<GetStorefrontByIdAction.GetStorefrontByIdRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertNotEquals(null, responses[0].data, 'Data should not be null');
    }
    
    @IsTest
    static void testGetStorefrontByIdError() {
        // Create test request
        GetStorefrontByIdAction.GetStorefrontByIdRequest request = new GetStorefrontByIdAction.GetStorefrontByIdRequest();
        request.id = 'test-id-1';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Storefront not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<GetStorefrontByIdAction.GetStorefrontByIdResponse> responses = GetStorefrontByIdAction.execute(new List<GetStorefrontByIdAction.GetStorefrontByIdRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 