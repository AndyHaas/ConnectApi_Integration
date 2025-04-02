/**
 * @description Test class for GetWarehouseProductByIdAction.
 * This class provides test coverage for retrieving warehouse products by ID,
 * including successful retrieval and error handling scenarios.
 */
@IsTest
public class GetWarehouseProductByIdActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testGetWarehouseProductById() {
        // Create test request
        GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest request = new GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest();
        request.id = 'test-id-1';
        
        // Create test response
        WarehouseProductDto mockProduct = new WarehouseProductDto();
        mockProduct.id = 'test-id-1';
        mockProduct.warehouseId = 'test-warehouse-1';
        mockProduct.sku = 'TEST-SKU-001';
        mockProduct.name = 'Test Product';
        mockProduct.description = 'Test Description';
        mockProduct.price = 99.99;
        mockProduct.quantity = 100;
        mockProduct.status = 'ACTIVE';
        String mockResponse = JSON.serialize(mockProduct);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<GetWarehouseProductByIdAction.GetWarehouseProductByIdResponse> responses = 
            GetWarehouseProductByIdAction.execute(new List<GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('test-id-1', responses[0].data.id, 'Product ID should match');
        System.assertEquals('Test Product', responses[0].data.name, 'Product name should match');
        System.assertEquals('TEST-SKU-001', responses[0].data.sku, 'Product SKU should match');
    }
    
    @IsTest
    public static void testGetWarehouseProductByIdError() {
        // Create test request
        GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest request = new GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest();
        request.id = 'test-id-1';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Product not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<GetWarehouseProductByIdAction.GetWarehouseProductByIdResponse> responses = 
            GetWarehouseProductByIdAction.execute(new List<GetWarehouseProductByIdAction.GetWarehouseProductByIdRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 