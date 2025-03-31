@IsTest
private class GetStorefrontProductByIdActionTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testGetStorefrontProductById() {
        Test.startTest();
        
        // Create test request
        GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest request = new GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest();
        request.productId = 'test-product-id';
        
        // Create mock response
        String mockResponse = JSON.serialize(new StorefrontProductDto());
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Call action
        List<GetStorefrontProductByIdAction.GetStorefrontProductByIdResponse> responses = GetStorefrontProductByIdAction.execute(new List<GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest>{request});
        
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
        GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest request = new GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest();
        
        // Call action
        List<GetStorefrontProductByIdAction.GetStorefrontProductByIdResponse> responses = GetStorefrontProductByIdAction.execute(new List<GetStorefrontProductByIdAction.GetStorefrontProductByIdRequest>{request});
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 