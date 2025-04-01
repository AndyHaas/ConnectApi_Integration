@IsTest
private class GetWarehouseActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testGetWarehouse() {
        // Create test request
        GetWarehouseAction.GetWarehouseRequest request = new GetWarehouseAction.GetWarehouseRequest();
        request.id = 'test-id-1';
        
        // Create mock response
        WarehouseDto mockResponse = new WarehouseDto();
        mockResponse.id = 'test-id-1';
        mockResponse.name = 'Test Warehouse';
        mockResponse.code = 'WH1';
        mockResponse.addressLine1 = '123 Test St';
        mockResponse.addressCity = 'Test City';
        mockResponse.addressState = 'TS';
        mockResponse.addressZipCode = '12345';
        mockResponse.addressCountryCode = 'US';
        
        // Setup mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', JSON.serialize(mockResponse)));
        
        Test.startTest();
        List<GetWarehouseAction.GetWarehouseResponse> responses = 
            GetWarehouseAction.execute(new List<GetWarehouseAction.GetWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('Test Warehouse', responses[0].data.name, 'Warehouse name should match');
        System.assertEquals('WH1', responses[0].data.code, 'Warehouse code should match');
    }
    
    @IsTest
    static void testGetWarehouseError() {
        // Create test request
        GetWarehouseAction.GetWarehouseRequest request = new GetWarehouseAction.GetWarehouseRequest();
        request.id = 'invalid-id';
        
        // Setup mock error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', 'Warehouse not found'));
        
        Test.startTest();
        List<GetWarehouseAction.GetWarehouseResponse> responses = 
            GetWarehouseAction.execute(new List<GetWarehouseAction.GetWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should indicate failure');
        System.assertEquals('Not Found', responses[0].message, 'Error message should match');
    }
} 