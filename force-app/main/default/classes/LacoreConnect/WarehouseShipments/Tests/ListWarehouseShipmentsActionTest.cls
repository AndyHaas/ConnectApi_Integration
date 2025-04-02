/**
 * @description Test class for ListWarehouseShipmentsAction.
 * This class provides test coverage for listing warehouse shipments,
 * including successful retrieval, pagination, and error handling scenarios.
 */
@IsTest
public class ListWarehouseShipmentsActionTest {
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testListWarehouseShipmentsSuccess() {
        // Create test data
        WarehouseShipmentDto shipment = new WarehouseShipmentDto();
        shipment.id = '1';
        shipment.name = 'Test Shipment';
        
        List<WarehouseShipmentDto> shipments = new List<WarehouseShipmentDto>{shipment};
        
        // Create paginated response
        PaginatedResponseDto mockResponse = new PaginatedResponseDto();
        mockResponse.items = shipments;
        mockResponse.perPage = 10;
        mockResponse.total = 1;
        mockResponse.page = 1;
        mockResponse.totalPages = 1;
        
        // Set up mock to return success response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'Success', JSON.serialize(mockResponse)));
        
        // Create request
        ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest request = new ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest();
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'name';
        request.sortDir = 'asc';
        
        // Execute the action
        Test.startTest();
        List<ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse> responses = 
            ListWarehouseShipmentsAction.execute(new List<ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals(1, response.items.size(), 'Should return one shipment');
        System.assertEquals('Test Shipment', response.items[0].name, 'Should return correct shipment name');
        System.assertEquals(10, response.perPage, 'Should return correct perPage value');
        System.assertEquals(1, response.total, 'Should return correct total value');
        System.assertEquals(1, response.page, 'Should return correct page value');
        System.assertEquals(1, response.totalPages, 'Should return correct totalPages value');
    }
    
    @IsTest
    public static void testListWarehouseShipmentsError() {
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        // Create request
        ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest request = new ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest();
        request.page = 1;
        request.pageSize = 10;
        
        // Execute the action
        Test.startTest();
        List<ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse> responses = 
            ListWarehouseShipmentsAction.execute(new List<ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Should return correct error message');
    }
} 