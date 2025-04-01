@IsTest
private class CreateWarehouseActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testCreateWarehouse() {
        // Create test request
        CreateWarehouseAction.CreateWarehouseRequest request = new CreateWarehouseAction.CreateWarehouseRequest();
        request.data = new WarehouseDto();
        request.data.name = 'New Warehouse';
        request.data.code = 'WH3';
        request.data.addressLine1 = '789 Test Blvd';
        request.data.addressCity = 'Test City';
        request.data.addressState = 'TS';
        request.data.addressZipCode = '12345';
        request.data.addressCountryCode = 'US';
        
        // Create mock response
        WarehouseDto mockResponse = new WarehouseDto();
        mockResponse.id = 'test-id-3';
        mockResponse.name = 'New Warehouse';
        mockResponse.code = 'WH3';
        mockResponse.addressLine1 = '789 Test Blvd';
        mockResponse.addressCity = 'Test City';
        mockResponse.addressState = 'TS';
        mockResponse.addressZipCode = '12345';
        mockResponse.addressCountryCode = 'US';
        
        // Setup mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Created', JSON.serialize(mockResponse)));
        
        Test.startTest();
        List<CreateWarehouseAction.CreateWarehouseResponse> responses = 
            CreateWarehouseAction.execute(new List<CreateWarehouseAction.CreateWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('New Warehouse', responses[0].data.name, 'Warehouse name should match');
        System.assertEquals('WH3', responses[0].data.code, 'Warehouse code should match');
    }
    
    @IsTest
    static void testCreateWarehouseError() {
        // Create test request with invalid data
        CreateWarehouseAction.CreateWarehouseRequest request = new CreateWarehouseAction.CreateWarehouseRequest();
        request.data = new WarehouseDto();
        request.data.name = ''; // Invalid: empty name
        
        // Setup mock error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', 'Warehouse name is required'));
        
        Test.startTest();
        List<CreateWarehouseAction.CreateWarehouseResponse> responses = 
            CreateWarehouseAction.execute(new List<CreateWarehouseAction.CreateWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should indicate failure');
        System.assertEquals('Bad Request', responses[0].message, 'Error message should match');
    }
} 