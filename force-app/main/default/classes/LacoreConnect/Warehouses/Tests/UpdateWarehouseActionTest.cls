/**
 * @description Test class for UpdateWarehouseAction.
 * This class provides test coverage for updating warehouses,
 * including successful updates and error handling scenarios.
 */
@IsTest
public class UpdateWarehouseActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testUpdateWarehouse() {
        // Create test request
        UpdateWarehouseAction.UpdateWarehouseRequest request = new UpdateWarehouseAction.UpdateWarehouseRequest();
        request.data = new WarehouseDto();
        request.data.id = 'test-id-1';
        request.data.name = 'Updated Warehouse';
        request.data.code = 'WH1';
        request.data.addressLine1 = '789 Test Blvd';
        request.data.addressCity = 'Test City';
        request.data.addressState = 'TS';
        request.data.addressZipCode = '12345';
        request.data.addressCountryCode = 'US';
        
        // Create mock response
        WarehouseDto mockResponse = new WarehouseDto();
        mockResponse.id = 'test-id-1';
        mockResponse.name = 'Updated Warehouse';
        mockResponse.code = 'WH1';
        mockResponse.addressLine1 = '789 Test Blvd';
        mockResponse.addressCity = 'Test City';
        mockResponse.addressState = 'TS';
        mockResponse.addressZipCode = '12345';
        mockResponse.addressCountryCode = 'US';
        
        // Setup mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', JSON.serialize(mockResponse)));
        
        Test.startTest();
        List<UpdateWarehouseAction.UpdateWarehouseResponse> responses = 
            UpdateWarehouseAction.execute(new List<UpdateWarehouseAction.UpdateWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals('Updated Warehouse', responses[0].data.name, 'Warehouse name should match');
        System.assertEquals('WH1', responses[0].data.code, 'Warehouse code should match');
    }
    
    @IsTest
    public static void testUpdateWarehouseError() {
        // Create test request with invalid data
        UpdateWarehouseAction.UpdateWarehouseRequest request = new UpdateWarehouseAction.UpdateWarehouseRequest();
        request.data = new WarehouseDto();
        request.data.id = 'invalid-id';
        request.data.name = 'Updated Warehouse';
        
        // Setup mock error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(404, 'Not Found', 'Warehouse not found'));
        
        Test.startTest();
        List<UpdateWarehouseAction.UpdateWarehouseResponse> responses = 
            UpdateWarehouseAction.execute(new List<UpdateWarehouseAction.UpdateWarehouseRequest>{request});
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should indicate failure');
        System.assertEquals('Not Found', responses[0].message, 'Error message should match');
    }
} 