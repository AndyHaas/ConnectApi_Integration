/**
 * @description Test class for GetStorefrontsAction.
 * This class provides test coverage for listing storefronts,
 * including successful retrieval and error handling scenarios.
 */
@IsTest
public class GetStorefrontsActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testGetStorefronts() {
        // Create test request
        GetStorefrontsAction.GetStorefrontsRequest request = new GetStorefrontsAction.GetStorefrontsRequest();
        request.page = 1;
        request.pageSize = 10;
        request.sortDir = 'ASC';
        
        // Create test response
        StorefrontDto mockStorefront = new StorefrontDto();
        mockStorefront.id = 'test-id-1';
        mockStorefront.name = 'Test Storefront';
        mockStorefront.description = 'Test Description';
        mockStorefront.status = 'ACTIVE';
        
        String mockResponse = JSON.serialize(mockStorefront);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<GetStorefrontsAction.GetStorefrontsResponse> responses = GetStorefrontsAction.execute(new List<GetStorefrontsAction.GetStorefrontsRequest>{request});
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
    }
    
    @IsTest
    public static void testGetStorefrontsError() {
        // Create test request
        GetStorefrontsAction.GetStorefrontsRequest request = new GetStorefrontsAction.GetStorefrontsRequest();
        
        // Create test error response
        String mockErrorResponse = '{"error": "Failed to retrieve storefronts"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(500, 'Internal Server Error', mockErrorResponse));
        
        // Execute the action
        List<GetStorefrontsAction.GetStorefrontsResponse> responses = GetStorefrontsAction.execute(new List<GetStorefrontsAction.GetStorefrontsRequest>{request});
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 