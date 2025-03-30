@IsTest
private class ListShipmentsActionTest {
    
    @TestSetup
    static void setup() {
        // Create test data
    }
    
    @IsTest
    static void testListShipments() {
        // Prepare test request
        ListShipmentsAction.ListShipmentsRequest request = new ListShipmentsAction.ListShipmentsRequest();
        request.brandId = 'test-brand-id';
        request.warehouseId = 'test-warehouse-id';
        request.status = 'active';
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'createdAt';
        request.sortDir = 'desc';
        
        // Execute test
        Test.startTest();
        List<ListShipmentsAction.ListShipmentsResponse> responses = 
            ListShipmentsAction.execute(new List<ListShipmentsAction.ListShipmentsRequest>{ request });
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should have one response');
        ListShipmentsAction.ListShipmentsResponse response = responses[0];
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertNotEquals(null, response.data, 'Response data should not be null');
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        ListShipmentsAction.ListShipmentsRequest request = new ListShipmentsAction.ListShipmentsRequest();
        
        // Call action
        List<ListShipmentsAction.ListShipmentsResponse> responses = 
            ListShipmentsAction.execute(new List<ListShipmentsAction.ListShipmentsRequest>{ request });
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testListShipmentsWithOptionalFields() {
        // Prepare test request with only required fields
        ListShipmentsAction.ListShipmentsRequest request = new ListShipmentsAction.ListShipmentsRequest();
        request.brandId = 'test-brand-id';
        request.warehouseId = 'test-warehouse-id';
        
        // Execute test
        Test.startTest();
        List<ListShipmentsAction.ListShipmentsResponse> responses = 
            ListShipmentsAction.execute(new List<ListShipmentsAction.ListShipmentsRequest>{ request });
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should have one response');
        ListShipmentsAction.ListShipmentsResponse response = responses[0];
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertNotEquals(null, response.data, 'Response data should not be null');
    }
} 