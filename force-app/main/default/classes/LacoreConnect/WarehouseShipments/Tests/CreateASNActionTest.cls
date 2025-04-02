/**
 * @description Test class for CreateASNAction.
 * This class provides test coverage for creating Advanced Shipping Notices (ASN),
 * including successful creation and error handling scenarios.
 */
@IsTest
public class CreateASNActionTest {
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testCreateASNSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test ASN';
        mockResponse.type = 2; // ASN type
        mockResponse.status = 'Pending';
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test ASN';
        shipment.vendorId = '1';
        shipment.toWarehouseId = '2';
        shipment.type = 'ASN';
        
        CreateASNAction.CreateASNRequest request = new CreateASNAction.CreateASNRequest();
        request.shipment = shipment;
        
        // Execute the action
        Test.startTest();
        List<CreateASNAction.CreateASNResponse> responses = 
            CreateASNAction.execute(new List<CreateASNAction.CreateASNRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CreateASNAction.CreateASNResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test ASN', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Pending', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    public static void testCreateASNError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test ASN';
        
        CreateASNAction.CreateASNRequest request = new CreateASNAction.CreateASNRequest();
        request.shipment = shipment;
        
        // Execute the action
        Test.startTest();
        List<CreateASNAction.CreateASNResponse> responses = 
            CreateASNAction.execute(new List<CreateASNAction.CreateASNRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CreateASNAction.CreateASNResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Should return correct error message');
    }
} 