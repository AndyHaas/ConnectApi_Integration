/**
 * @description Test class for CreateStorefrontProductAction.
 * This class provides test coverage for creating storefront products,
 * including successful creation and error handling scenarios.
 */
@IsTest
public class CreateStorefrontProductActionTest {
    
    @TestSetup
    public static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    public static void testCreateStorefrontProduct() {
        Test.startTest();
        
        // Create test request
        CreateStorefrontProductAction.CreateStorefrontProductRequest request = new CreateStorefrontProductAction.CreateStorefrontProductRequest();
        request.data = new StorefrontProductDto();
        request.data.name = 'Test Product';
        request.data.description = 'Test Description';
        request.data.sku = 'TEST-SKU-001';
        request.data.price = 99.99;
        request.data.quantity = 100;
        request.data.status = 'ACTIVE';
        request.data.brandId = 'test-brand';
        request.data.categoryId = 'test-category';

        // Create mock response
        String mockResponse = JSON.serialize(request.data);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Call action
        List<CreateStorefrontProductAction.CreateStorefrontProductResponse> responses = CreateStorefrontProductAction.execute(new List<CreateStorefrontProductAction.CreateStorefrontProductRequest>{request});
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertNotEquals(null, responses[0].data, 'Response data should not be null');
        
        Test.stopTest();
    }
    
    @IsTest
    public static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        CreateStorefrontProductAction.CreateStorefrontProductRequest request = new CreateStorefrontProductAction.CreateStorefrontProductRequest();
        
        // Call action
        List<CreateStorefrontProductAction.CreateStorefrontProductResponse> responses = CreateStorefrontProductAction.execute(new List<CreateStorefrontProductAction.CreateStorefrontProductRequest>{request});
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 