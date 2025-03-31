@IsTest
private class DeleteStorefrontProductActionTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testDeleteStorefrontProduct() {
        Test.startTest();
        
        // Create test request
        DeleteStorefrontProductAction.DeleteStorefrontProductRequest request = new DeleteStorefrontProductAction.DeleteStorefrontProductRequest();
        request.productId = 'test-product-id';

        // Create mock response
        String mockResponse = JSON.serialize(request);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Call action
        List<DeleteStorefrontProductAction.DeleteStorefrontProductResponse> responses = DeleteStorefrontProductAction.execute(new List<DeleteStorefrontProductAction.DeleteStorefrontProductRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        DeleteStorefrontProductAction.DeleteStorefrontProductRequest request = new DeleteStorefrontProductAction.DeleteStorefrontProductRequest();
        
        // Call action
        List<DeleteStorefrontProductAction.DeleteStorefrontProductResponse> responses = DeleteStorefrontProductAction.execute(new List<DeleteStorefrontProductAction.DeleteStorefrontProductRequest>{request});
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 