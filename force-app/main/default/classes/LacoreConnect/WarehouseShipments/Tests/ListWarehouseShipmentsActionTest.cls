@IsTest
private class ListWarehouseShipmentsActionTest {
    @IsTest
    static void testListWarehouseShipmentsSuccess() {
        // Create test data
        WarehouseShipmentDto shipment = new WarehouseShipmentDto();
        shipment.id = '1';
        shipment.name = 'Test Shipment';
        
        List<WarehouseShipmentDto> shipments = new List<WarehouseShipmentDto>{shipment};
        
        WarehouseShipmentDtoPaginatedItemsResponse mockResponse = new WarehouseShipmentDtoPaginatedItemsResponse();
        mockResponse.items = shipments;
        mockResponse.perPage = 10;
        mockResponse.total = 1;
        mockResponse.page = 1;
        mockResponse.totalPages = 1;
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest request = new ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest();
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'name';
        request.sortDir = 'asc';
        
        // Execute the action
        List<ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse> responses = 
            ListWarehouseShipmentsAction.execute(new List<ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals(1, response.shipments.size(), 'Should return one shipment');
        System.assertEquals('Test Shipment', response.shipments[0].name, 'Should return correct shipment name');
        System.assertEquals(10, response.perPage, 'Should return correct perPage value');
        System.assertEquals(1, response.total, 'Should return correct total value');
        System.assertEquals(1, response.page, 'Should return correct page value');
        System.assertEquals(1, response.totalPages, 'Should return correct totalPages value');
    }
    
    @IsTest
    static void testListWarehouseShipmentsError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest request = new ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest();
        request.page = 1;
        request.pageSize = 10;
        
        // Execute the action
        List<ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse> responses = 
            ListWarehouseShipmentsAction.execute(new List<ListWarehouseShipmentsAction.ListWarehouseShipmentsRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ListWarehouseShipmentsAction.ListWarehouseShipmentsResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 