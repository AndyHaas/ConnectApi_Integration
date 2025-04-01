@IsTest
private class GetWarehouseProductInventoryActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testGetWarehouseProductInventory() {
        // Create test request with all parameters
        GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest request = new GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest();
        request.item = 'TEST-SKU-001';
        request.warehouseProductId = 'test-warehouse-product-id';
        request.warehouseId = 'test-warehouse-id';
        request.brandId = 'test-brand-id';
        request.lpn = 'TEST-LPN-001';
        request.locationCode = 'LOC-001';
        request.lotNumber = 'LOT-001';
        request.page = 1;
        request.pageSize = 10;
        request.sortDir = 'ASC';
        
        // Create mock response data
        WarehouseProductInventoryDto mockInventory = new WarehouseProductInventoryDto();
        mockInventory.id = 'test-inventory-id';
        mockInventory.warehouseProductId = request.warehouseProductId;
        mockInventory.quantity = 100;
        mockInventory.locationCode = request.locationCode;
        mockInventory.lpn = request.lpn;
        mockInventory.lotNumber = request.lotNumber;
        mockInventory.item = request.item;
        mockInventory.warehouseId = request.warehouseId;
        mockInventory.brandId = request.brandId;
        mockInventory.quantityAvailable = 90;
        mockInventory.quantityOnHold = 5;
        mockInventory.quantityUnavailable = 5;
        mockInventory.isOnHold = false;
        mockInventory.isQuarantined = false;
        
        // Create paginated response
        WarehouseProductInventoryResponseDto mockResponse = new WarehouseProductInventoryResponseDto();
        mockResponse.items = new List<WarehouseProductInventoryDto>{mockInventory};
        mockResponse.perPage = request.pageSize;
        mockResponse.total = 1;
        mockResponse.page = request.page;
        mockResponse.totalPages = 1;
        
        // Set up mock response
        String mockResponseBody = JSON.serialize(mockResponse);
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponseBody));
        
        // Execute the action
        List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryResponse> responses = 
            GetWarehouseProductInventoryAction.execute(new List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals(1, responses[0].data.items.size(), 'Should have one inventory item');
        System.assertEquals(request.warehouseProductId, responses[0].data.items[0].warehouseProductId, 'Warehouse Product ID should match');
        System.assertEquals(request.locationCode, responses[0].data.items[0].locationCode, 'Location Code should match');
        System.assertEquals(request.lpn, responses[0].data.items[0].lpn, 'LPN should match');
        System.assertEquals(request.lotNumber, responses[0].data.items[0].lotNumber, 'Lot Number should match');
        System.assertEquals(request.pageSize, responses[0].data.perPage, 'Page size should match');
        System.assertEquals(request.page, responses[0].data.page, 'Page number should match');
    }
    
    @IsTest
    static void testGetWarehouseProductInventoryError() {
        // Create test request with minimal parameters
        GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest request = new GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest();
        request.warehouseProductId = 'test-warehouse-product-id';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Warehouse product not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryResponse> responses = 
            GetWarehouseProductInventoryAction.execute(new List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
    
    @IsTest
    static void testGetWarehouseProductInventoryWithPagination() {
        // Create test request with pagination parameters
        GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest request = new GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest();
        request.warehouseProductId = 'test-warehouse-product-id';
        request.page = 2;
        request.pageSize = 20;
        request.sortDir = 'DESC';
        
        // Create mock response data
        WarehouseProductInventoryDto mockInventory = new WarehouseProductInventoryDto();
        mockInventory.id = 'test-inventory-id';
        mockInventory.warehouseProductId = request.warehouseProductId;
        mockInventory.quantity = 50;
        
        // Create paginated response
        WarehouseProductInventoryResponseDto mockResponse = new WarehouseProductInventoryResponseDto();
        mockResponse.items = new List<WarehouseProductInventoryDto>{mockInventory};
        mockResponse.perPage = request.pageSize;
        mockResponse.total = 1;
        mockResponse.page = request.page;
        mockResponse.totalPages = 1;
        
        // Set up mock response
        String mockResponseBody = JSON.serialize(mockResponse);
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponseBody));
        
        // Execute the action
        List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryResponse> responses = 
            GetWarehouseProductInventoryAction.execute(new List<GetWarehouseProductInventoryAction.GetWarehouseProductInventoryRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals(1, responses[0].data.items.size(), 'Should have one inventory item');
        System.assertEquals(request.warehouseProductId, responses[0].data.items[0].warehouseProductId, 'Warehouse Product ID should match');
        System.assertEquals(request.pageSize, responses[0].data.perPage, 'Page size should match');
        System.assertEquals(request.page, responses[0].data.page, 'Page number should match');
    }
} 