/**
 * @description Test class for CreateWarehouseProductAction.
 * This class provides test coverage for creating warehouse products,
 * including successful creation and error handling scenarios.
 */
@IsTest
public class CreateWarehouseProductActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testCreateWarehouseProduct() {
        // Create test request
        CreateWarehouseProductAction.CreateWarehouseProductRequest request = new CreateWarehouseProductAction.CreateWarehouseProductRequest();
        request.product = new WarehouseProductDto();
        request.product.warehouseId = 'test-warehouse-1';
        request.product.sku = 'TEST-SKU-001';
        request.product.name = 'Test Product';
        request.product.description = 'Test Description';
        request.product.price = 99.99;
        request.product.quantity = 100;
        request.product.status = 'ACTIVE';
        
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
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(201, 'Created', mockResponse));
        
        // Execute the action
        List<CreateWarehouseProductAction.CreateWarehouseProductResponse> responses = 
            CreateWarehouseProductAction.execute(new List<CreateWarehouseProductAction.CreateWarehouseProductRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('test-id-1', responses[0].data.id, 'Product ID should match');
        System.assertEquals('Test Product', responses[0].data.name, 'Product name should match');
        System.assertEquals('TEST-SKU-001', responses[0].data.sku, 'Product SKU should match');
    }
    
    @IsTest
    public static void testCreateWarehouseProductError() {
        // Create test request
        CreateWarehouseProductAction.CreateWarehouseProductRequest request = new CreateWarehouseProductAction.CreateWarehouseProductRequest();
        request.product = new WarehouseProductDto();
        request.product.warehouseId = 'test-warehouse-1';
        request.product.sku = 'TEST-SKU-001';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Invalid product data"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', mockErrorResponse));
        
        // Execute the action
        List<CreateWarehouseProductAction.CreateWarehouseProductResponse> responses = 
            CreateWarehouseProductAction.execute(new List<CreateWarehouseProductAction.CreateWarehouseProductRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 