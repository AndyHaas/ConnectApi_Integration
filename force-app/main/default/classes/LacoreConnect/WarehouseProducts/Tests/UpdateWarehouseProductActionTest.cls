/**
 * @description Test class for UpdateWarehouseProductAction.
 * This class provides test coverage for updating warehouse products,
 * including successful updates and error handling scenarios.
 */
@IsTest
public class UpdateWarehouseProductActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testUpdateWarehouseProduct() {
        // Create test request
        UpdateWarehouseProductAction.UpdateWarehouseProductRequest request = new UpdateWarehouseProductAction.UpdateWarehouseProductRequest();
        request.id = 'test-id-1';
        request.product = new WarehouseProductDto();
        request.product.id = 'test-id-1';
        request.product.warehouseId = 'test-warehouse-1';
        request.product.sku = 'TEST-SKU-001';
        request.product.name = 'Updated Product';
        request.product.description = 'Updated Description';
        request.product.price = 149.99;
        request.product.quantity = 200;
        request.product.status = 'ACTIVE';
        
        // Create test response
        WarehouseProductDto mockProduct = new WarehouseProductDto();
        mockProduct.id = 'test-id-1';
        mockProduct.warehouseId = 'test-warehouse-1';
        mockProduct.sku = 'TEST-SKU-001';
        mockProduct.name = 'Updated Product';
        mockProduct.description = 'Updated Description';
        mockProduct.price = 149.99;
        mockProduct.quantity = 200;
        mockProduct.status = 'ACTIVE';
        String mockResponse = JSON.serialize(mockProduct);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<UpdateWarehouseProductAction.UpdateWarehouseProductResponse> responses = 
            UpdateWarehouseProductAction.execute(new List<UpdateWarehouseProductAction.UpdateWarehouseProductRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('test-id-1', responses[0].data.id, 'Product ID should match');
        System.assertEquals('Updated Product', responses[0].data.name, 'Product name should match');
        System.assertEquals(149.99, responses[0].data.price, 'Product price should match');
        System.assertEquals(200, responses[0].data.quantity, 'Product quantity should match');
    }
    
    @IsTest
    public static void testUpdateWarehouseProductError() {
        // Create test request
        UpdateWarehouseProductAction.UpdateWarehouseProductRequest request = new UpdateWarehouseProductAction.UpdateWarehouseProductRequest();
        request.id = 'test-id-1';
        request.product = new WarehouseProductDto();
        request.product.id = 'test-id-1';
        request.product.warehouseId = 'test-warehouse-1';
        request.product.sku = 'TEST-SKU-001';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Product not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<UpdateWarehouseProductAction.UpdateWarehouseProductResponse> responses = 
            UpdateWarehouseProductAction.execute(new List<UpdateWarehouseProductAction.UpdateWarehouseProductRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 