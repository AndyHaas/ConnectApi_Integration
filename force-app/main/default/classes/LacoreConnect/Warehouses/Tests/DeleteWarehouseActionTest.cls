@IsTest
private class DeleteWarehouseActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testDeleteWarehouse() {
        // Create test request
        DeleteWarehouseAction.DeleteWarehouseRequest request = new DeleteWarehouseAction.DeleteWarehouseRequest();
        request.warehouseId = 'test-id-1';
        
        // Setup mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(204, 'No Content', ''));
        
        Test.startTest();
        List<DeleteWarehouseAction.DeleteWarehouseResponse> responses = 
            DeleteWarehouseAction.execute(new List<DeleteWarehouseAction.DeleteWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('Warehouse deleted successfully', responses[0].message, 'Success message should match');
    }
    
    @IsTest
    static void testDeleteWarehouseError() {
        // Create test request with invalid ID
        DeleteWarehouseAction.DeleteWarehouseRequest request = new DeleteWarehouseAction.DeleteWarehouseRequest();
        request.warehouseId = 'invalid-id';
        
        // Setup mock error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', 'Warehouse not found'));
        
        Test.startTest();
        List<DeleteWarehouseAction.DeleteWarehouseResponse> responses = 
            DeleteWarehouseAction.execute(new List<DeleteWarehouseAction.DeleteWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should indicate failure');
        System.assertEquals('Not Found', responses[0].message, 'Error message should match');
    }
} 