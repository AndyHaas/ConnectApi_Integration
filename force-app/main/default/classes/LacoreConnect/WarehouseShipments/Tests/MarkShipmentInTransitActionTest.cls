/**
 * @description Test class for MarkShipmentInTransitAction.
 * This class provides test coverage for marking warehouse shipments as in transit,
 * including successful status updates and error handling scenarios.
 */
@IsTest
public class MarkShipmentInTransitActionTest {
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testMarkShipmentInTransitSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'In Transit';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        MarkShipmentInTransitAction.MarkShipmentInTransitRequest request = new MarkShipmentInTransitAction.MarkShipmentInTransitRequest();
        request.id = '1';
        
        // Execute the action
        Test.startTest();
        List<MarkShipmentInTransitAction.MarkShipmentInTransitResponse> responses = 
            MarkShipmentInTransitAction.execute(new List<MarkShipmentInTransitAction.MarkShipmentInTransitRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        MarkShipmentInTransitAction.MarkShipmentInTransitResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('In Transit', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    public static void testMarkShipmentInTransitError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        MarkShipmentInTransitAction.MarkShipmentInTransitRequest request = new MarkShipmentInTransitAction.MarkShipmentInTransitRequest();
        request.id = '1';
        
        // Execute the action
        Test.startTest();
        List<MarkShipmentInTransitAction.MarkShipmentInTransitResponse> responses = 
            MarkShipmentInTransitAction.execute(new List<MarkShipmentInTransitAction.MarkShipmentInTransitRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        MarkShipmentInTransitAction.MarkShipmentInTransitResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Should return correct error message');
    }
} 