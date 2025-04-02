/**
 * @description Test class for GetVendorAction.
 * This class provides test coverage for retrieving vendor information,
 * including successful retrieval and error handling scenarios.
 */
@IsTest
public class GetVendorActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testGetVendor() {        
        // Create test response
        VendorDto mockVendor = new VendorDto();
        mockVendor.id = 'test-id-1';
        mockVendor.name = 'Test Vendor';
        mockVendor.code = 'TEST-VENDOR-001';
        mockVendor.status = 'ACTIVE';
        String mockResponse = JSON.serialize(mockVendor);
        
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', mockResponse));
        
        // Execute the action
        List<GetVendorAction.GetVendorResponse> responses = 
            GetVendorAction.execute();
        
        // Verify the response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('test-id-1', responses[0].data.id, 'Vendor ID should match');
        System.assertEquals('Test Vendor', responses[0].data.name, 'Vendor name should match');
        System.assertEquals('TEST-VENDOR-001', responses[0].data.code, 'Vendor code should match');
        System.assertEquals('ACTIVE', responses[0].data.status, 'Vendor status should match');
    }
    
    @IsTest
    public static void testGetVendorError() {        
        // Create test error response
        String mockErrorResponse = '{"error": "Vendor not found"}';
        
        // Set up mock response with error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', mockErrorResponse));
        
        // Execute the action
        List<GetVendorAction.GetVendorResponse> responses = 
            GetVendorAction.execute();
        
        // Verify the error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
    }
} 