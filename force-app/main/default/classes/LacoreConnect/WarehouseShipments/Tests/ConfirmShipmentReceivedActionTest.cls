/**
 * @description Test class for ConfirmShipmentReceivedAction.
 * This class provides test coverage for confirming receipt of warehouse shipments,
 * including successful confirmation and error handling scenarios.
 */
@IsTest
public class ConfirmShipmentReceivedActionTest {
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testConfirmShipmentReceivedSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'Received';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        WarehouseShipmentConfirmReceivedReq confirmation = new WarehouseShipmentConfirmReceivedReq();
        confirmation.note = 'Test confirmation';
        
        WarehouseShipmentItemConfirmReceivedReq item = new WarehouseShipmentItemConfirmReceivedReq();
        item.id = 1;
        item.quantityReceived = 10;
        item.lotNumber = 'LOT123';
        item.lpn = 'LPN123';
        confirmation.items = new List<WarehouseShipmentItemConfirmReceivedReq>{item};
        
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest request = new ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest();
        request.id = '1';
        request.confirmation = confirmation;
        
        // Execute the action
        Test.startTest();
        List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse> responses = 
            ConfirmShipmentReceivedAction.execute(new List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Received', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    public static void testConfirmShipmentReceivedError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        WarehouseShipmentConfirmReceivedReq confirmation = new WarehouseShipmentConfirmReceivedReq();
        confirmation.note = 'Test confirmation';
        
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest request = new ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest();
        request.id = '1';
        request.confirmation = confirmation;
        
        // Execute the action
        Test.startTest();
        List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse> responses = 
            ConfirmShipmentReceivedAction.execute(new List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Should return correct error message');
    }
} 