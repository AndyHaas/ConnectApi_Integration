@IsTest
private class GetStorefrontProductsActionTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testGetStorefrontProducts() {
        Test.startTest();
        
        // Create test request
        GetStorefrontProductsAction.GetStorefrontProductsRequest request = new GetStorefrontProductsAction.GetStorefrontProductsRequest();
        request.storefrontId = 'test-storefront';
        request.page = 1;
        request.pageSize = 10;
        request.sortDir = 'ASC';
        
        // Create mock response
        String mockResponse = JSON.serialize(new List<StorefrontProductDto>());
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Call action
        List<GetStorefrontProductsAction.GetStorefrontProductsResponse> responses = GetStorefrontProductsAction.execute(new List<GetStorefrontProductsAction.GetStorefrontProductsRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        GetStorefrontProductsAction.GetStorefrontProductsRequest request = new GetStorefrontProductsAction.GetStorefrontProductsRequest();
        
        // Call action
        List<GetStorefrontProductsAction.GetStorefrontProductsResponse> responses = GetStorefrontProductsAction.execute(new List<GetStorefrontProductsAction.GetStorefrontProductsRequest>{request});
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 