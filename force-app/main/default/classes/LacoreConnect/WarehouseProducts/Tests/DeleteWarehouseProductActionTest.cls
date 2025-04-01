@IsTest
private class DeleteWarehouseProductActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testDeleteWarehouseProduct() {
        // Create test request
        DeleteWarehouseProductAction.DeleteWarehouseProductRequest request = new DeleteWarehouseProductAction.DeleteWarehouseProductRequest();
        request.id = 'test-id-1';
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(204, 'No Content', ''));
        
        // Execute the action
        List<DeleteWarehouseProductAction.DeleteWarehouseProductResponse> responses = 
            DeleteWarehouseProductAction.execute(new List<DeleteWarehouseProductAction.DeleteWarehouseProductRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
    }
    
    @IsTest
    static void testDeleteWarehouseProductError() {
        // Create test request
        DeleteWarehouseProductAction.DeleteWarehouseProductRequest request = new DeleteWarehouseProductAction.DeleteWarehouseProductRequest();
        request.id = 'test-id-1';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Product not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<DeleteWarehouseProductAction.DeleteWarehouseProductResponse> responses = 
            DeleteWarehouseProductAction.execute(new List<DeleteWarehouseProductAction.DeleteWarehouseProductRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 