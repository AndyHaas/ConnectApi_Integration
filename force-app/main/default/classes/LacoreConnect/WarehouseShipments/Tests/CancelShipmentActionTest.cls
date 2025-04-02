/**
 * @description Test class for CancelShipmentAction.
 * This class provides test coverage for canceling warehouse shipments,
 * including successful cancellation and error handling scenarios.
 */
@IsTest
public class CancelShipmentActionTest {
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testCancelShipmentSuccess() {
        // Create mock response
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = 'test-shipment-id';
        mockResponse.status = 'CANCELLED';
        mockResponse.referenceNumber = 'TEST-SHIP-001';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create test request
        CancelShipmentAction.CancelShipmentRequest request = new CancelShipmentAction.CancelShipmentRequest();
        request.id = 'test-shipment-id';
        request.cancelRequest = new WarehouseShipmentCancelReq();
        request.cancelRequest.note = 'Test cancellation';
        
        // Execute action
        Test.startTest();
        List<CancelShipmentAction.CancelShipmentResponse> responses = 
            CancelShipmentAction.execute(new List<CancelShipmentAction.CancelShipmentRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        CancelShipmentAction.CancelShipmentResponse response = responses[0];
        System.assertEquals(true, response.isSuccess, 'Response should be successful');
        System.assertEquals(mockResponse.id, response.shipment.id, 'Shipment ID should match');
        System.assertEquals(mockResponse.status, response.shipment.status, 'Shipment status should be CANCELLED');
    }
    
    @IsTest
    public static void testCancelShipmentError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create test request
        CancelShipmentAction.CancelShipmentRequest request = new CancelShipmentAction.CancelShipmentRequest();
        request.id = 'test-shipment-id';
        request.cancelRequest = new WarehouseShipmentCancelReq();
        request.cancelRequest.note = 'Test cancellation';
        
        // Execute action
        Test.startTest();
        List<CancelShipmentAction.CancelShipmentResponse> responses = 
            CancelShipmentAction.execute(new List<CancelShipmentAction.CancelShipmentRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        CancelShipmentAction.CancelShipmentResponse response = responses[0];
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Error message should match');
    }
} 