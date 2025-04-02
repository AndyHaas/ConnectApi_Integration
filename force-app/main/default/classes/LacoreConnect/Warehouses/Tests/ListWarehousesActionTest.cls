/**
 * @description Test class for ListWarehousesAction.
 * This class provides test coverage for listing warehouses,
 * including successful retrieval, pagination, and error handling scenarios.
 */
@IsTest
public class ListWarehousesActionTest {
    @TestSetup
    public static void setup() {
        // Setup test data if needed
    }
    
    @IsTest
    public static void testListWarehouses() {
        // Create test request
        ListWarehousesAction.ListWarehousesRequest request = new ListWarehousesAction.ListWarehousesRequest();
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'name';
        request.sortDir = 'asc';
        
        // Create mock response
        WarehouseDtoPaginatedItemsResponse mockResponse = new WarehouseDtoPaginatedItemsResponse();
        mockResponse.items = new List<WarehouseDto>();
        WarehouseDto mockWarehouse = new WarehouseDto();
        mockWarehouse.id = 'test-id-1';
        mockWarehouse.name = 'Test Warehouse 1';
        mockWarehouse.code = 'WH1';
        mockWarehouse.addressLine1 = '123 Test St';
        mockWarehouse.addressCity = 'Test City';
        mockWarehouse.addressState = 'TS';
        mockWarehouse.addressZipCode = '12345';
        mockWarehouse.addressCountryCode = 'US';
        mockResponse.items.add(mockWarehouse);
        
        WarehouseDto mockWarehouse2 = new WarehouseDto();
        mockWarehouse2.id = 'test-id-2';
        mockWarehouse2.name = 'Test Warehouse 2';
        mockWarehouse2.code = 'WH2';
        mockWarehouse2.addressLine1 = '456 Test Ave';
        mockWarehouse2.addressCity = 'Test City';
        mockWarehouse2.addressState = 'TS';
        mockWarehouse2.addressZipCode = '12345';
        mockWarehouse2.addressCountryCode = 'US';
        mockResponse.items.add(mockWarehouse2);
        
        mockResponse.perPage = 10;
        mockResponse.total = 2;
        mockResponse.page = 1;
        mockResponse.totalPages = 1;
        
        // Setup mock response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(200, 'OK', JSON.serialize(mockResponse)));
        
        Test.startTest();
        List<ListWarehousesAction.ListWarehousesResponse> responses = 
            ListWarehousesAction.execute(new List<ListWarehousesAction.ListWarehousesRequest>{request});
        Test.stopTest();
        
        // Verify response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(true, responses[0].success, 'Response should be successful');
        System.assertEquals(2, responses[0].data.items.size(), 'Should have two warehouses');
        System.assertEquals('Test Warehouse 1', responses[0].data.items[0].name, 'First warehouse name should match');
        System.assertEquals('Test Warehouse 2', responses[0].data.items[1].name, 'Second warehouse name should match');
    }
    
    @IsTest
    public static void testListWarehousesError() {
        // Create test request
        ListWarehousesAction.ListWarehousesRequest request = new ListWarehousesAction.ListWarehousesRequest();
        request.page = 1;
        request.pageSize = 10;
        
        // Setup mock error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', 'Invalid parameters'));
        
        Test.startTest();
        List<ListWarehousesAction.ListWarehousesResponse> responses = 
            ListWarehousesAction.execute(new List<ListWarehousesAction.ListWarehousesRequest>{request});
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should indicate failure');
        System.assertEquals('Bad Request', responses[0].message, 'Error message should match');
    }
} 