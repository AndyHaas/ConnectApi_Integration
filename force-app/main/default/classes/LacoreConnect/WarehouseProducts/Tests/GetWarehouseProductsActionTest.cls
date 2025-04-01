@IsTest
private class GetWarehouseProductsActionTest {
    @TestSetup
    static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    static void testGetWarehouseProducts() {
        // Create test request
        GetWarehouseProductsAction.GetWarehouseProductsRequest request = new GetWarehouseProductsAction.GetWarehouseProductsRequest();
        request.warehouseId = 'test-warehouse-1';
        request.sku = 'TEST-SKU-001';
        request.page = 1;
        request.pageSize = 10;
        request.sortDir = 'ASC';
        
        // Create test response
        List<WarehouseProductDto> mockProducts = new List<WarehouseProductDto>();
        WarehouseProductDto mockProduct = new WarehouseProductDto();
        mockProduct.id = 'test-id-1';
        mockProduct.warehouseId = 'test-warehouse-1';
        mockProduct.sku = 'TEST-SKU-001';
        mockProduct.name = 'Test Product';
        mockProduct.description = 'Test Description';
        mockProduct.price = 99.99;
        mockProduct.quantity = 100;
        mockProduct.status = 'ACTIVE';
        mockProducts.add(mockProduct);
        String mockResponse = JSON.serialize(mockProducts);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<GetWarehouseProductsAction.GetWarehouseProductsResponse> responses = 
            GetWarehouseProductsAction.execute(new List<GetWarehouseProductsAction.GetWarehouseProductsRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals(1, responses[0].data.size(), 'Should have one product');
        System.assertEquals('test-id-1', responses[0].data[0].id, 'Product ID should match');
        System.assertEquals('Test Product', responses[0].data[0].name, 'Product name should match');
        System.assertEquals('TEST-SKU-001', responses[0].data[0].sku, 'Product SKU should match');
    }
    
    @IsTest
    static void testGetWarehouseProductsError() {
        // Create test request
        GetWarehouseProductsAction.GetWarehouseProductsRequest request = new GetWarehouseProductsAction.GetWarehouseProductsRequest();
        request.warehouseId = 'test-warehouse-1';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Invalid warehouse ID"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<GetWarehouseProductsAction.GetWarehouseProductsResponse> responses = 
            GetWarehouseProductsAction.execute(new List<GetWarehouseProductsAction.GetWarehouseProductsRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 