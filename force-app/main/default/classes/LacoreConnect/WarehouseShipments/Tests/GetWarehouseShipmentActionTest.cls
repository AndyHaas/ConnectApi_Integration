/**
 * @description Test class for GetWarehouseShipmentAction.
 * This class provides test coverage for retrieving warehouse shipments,
 * including successful retrieval and error handling scenarios.
 */
@IsTest
public class GetWarehouseShipmentActionTest {
    @IsTest
    public static void testGetWarehouseShipmentSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'Pending';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        GetWarehouseShipmentAction.GetWarehouseShipmentRequest request = new GetWarehouseShipmentAction.GetWarehouseShipmentRequest();
        request.id = '1';
        
        // Execute the action
        List<GetWarehouseShipmentAction.GetWarehouseShipmentResponse> responses = 
            GetWarehouseShipmentAction.execute(new List<GetWarehouseShipmentAction.GetWarehouseShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        GetWarehouseShipmentAction.GetWarehouseShipmentResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Pending', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    public static void testGetWarehouseShipmentError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        GetWarehouseShipmentAction.GetWarehouseShipmentRequest request = new GetWarehouseShipmentAction.GetWarehouseShipmentRequest();
        request.id = '1';
        
        // Execute the action
        List<GetWarehouseShipmentAction.GetWarehouseShipmentResponse> responses = 
            GetWarehouseShipmentAction.execute(new List<GetWarehouseShipmentAction.GetWarehouseShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        GetWarehouseShipmentAction.GetWarehouseShipmentResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 