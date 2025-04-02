/**
 * @description Test class for CreateWarehouseTransferAction.
 * This class provides test coverage for creating warehouse transfers,
 * including successful creation and error handling scenarios.
 */
@IsTest
public class CreateWarehouseTransferActionTest {
    @IsTest
    public static void testCreateWarehouseTransferSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Transfer';
        mockResponse.type = 1; // Transfer type
        mockResponse.status = 'Pending';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test Transfer';
        shipment.fromWarehouseId = '1';   
        shipment.toWarehouseId = '2';
        shipment.type = 'Transfer';
        
        CreateWarehouseTransferAction.CreateWarehouseTransferRequest request = new CreateWarehouseTransferAction.CreateWarehouseTransferRequest();
        request.shipment = shipment;
        
        // Execute the action
        List<CreateWarehouseTransferAction.CreateWarehouseTransferResponse> responses = 
            CreateWarehouseTransferAction.execute(new List<CreateWarehouseTransferAction.CreateWarehouseTransferRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CreateWarehouseTransferAction.CreateWarehouseTransferResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Transfer', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Pending', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    public static void testCreateWarehouseTransferError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test Transfer';
        
        CreateWarehouseTransferAction.CreateWarehouseTransferRequest request = new CreateWarehouseTransferAction.CreateWarehouseTransferRequest();
        request.shipment = shipment;
        
        // Execute the action
        List<CreateWarehouseTransferAction.CreateWarehouseTransferResponse> responses = 
            CreateWarehouseTransferAction.execute(new List<CreateWarehouseTransferAction.CreateWarehouseTransferRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CreateWarehouseTransferAction.CreateWarehouseTransferResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 