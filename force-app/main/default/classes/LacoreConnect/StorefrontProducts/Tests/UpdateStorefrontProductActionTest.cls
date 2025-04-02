/**
 * @description Test class for UpdateStorefrontProductAction.
 * This class provides test coverage for updating storefront products,
 * including successful updates and error handling scenarios.
 */
@IsTest
public class UpdateStorefrontProductActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testUpdateStorefrontProduct() {
        // Create test request
        UpdateStorefrontProductAction.UpdateStorefrontProductRequest request = new UpdateStorefrontProductAction.UpdateStorefrontProductRequest();
        request.productId = 'test-product-id';
        request.data = new StorefrontProductDto();
        request.data.name = 'Updated Product';
        request.data.description = 'Updated Description';
        request.data.sku = 'TEST-SKU-001';
        request.data.price = 99.99;
        request.data.quantity = 100;
        request.data.status = 'ACTIVE';
        
        // Create test response
        String mockResponse = JSON.serialize(request.data);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<UpdateStorefrontProductAction.UpdateStorefrontProductResponse> responses = 
            UpdateStorefrontProductAction.execute(new List<UpdateStorefrontProductAction.UpdateStorefrontProductRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('Updated Product', responses[0].data.name, 'Product name should be updated');
        System.assertEquals('Updated Description', responses[0].data.description, 'Product description should be updated');
        System.assertEquals('TEST-SKU-001', responses[0].data.sku, 'Product SKU should be updated');
        System.assertEquals(99.99, responses[0].data.price, 'Product price should be updated');
        System.assertEquals(100, responses[0].data.quantity, 'Product quantity should be updated');
        System.assertEquals('ACTIVE', responses[0].data.status, 'Product status should be updated');
    }
    
    @IsTest
    public static void testUpdateStorefrontProductError() {
        // Create test request
        UpdateStorefrontProductAction.UpdateStorefrontProductRequest request = new UpdateStorefrontProductAction.UpdateStorefrontProductRequest();
        request.productId = 'test-product-id';
        request.data = new StorefrontProductDto();
        request.data.name = 'Updated Product';
        
        // Create test error response
        String mockErrorResponse = '{"error": "Product not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<UpdateStorefrontProductAction.UpdateStorefrontProductResponse> responses = 
            UpdateStorefrontProductAction.execute(new List<UpdateStorefrontProductAction.UpdateStorefrontProductRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
    
    @IsTest
    public static void testUpdateStorefrontProductException() {
        // Create test request with invalid data to trigger exception
        UpdateStorefrontProductAction.UpdateStorefrontProductRequest request = new UpdateStorefrontProductAction.UpdateStorefrontProductRequest();
        request.productId = 'test-product-id';
        request.data = null; // This will cause a null pointer exception
        
        // Execute the action
        List<UpdateStorefrontProductAction.UpdateStorefrontProductResponse> responses = 
            UpdateStorefrontProductAction.execute(new List<UpdateStorefrontProductAction.UpdateStorefrontProductRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 