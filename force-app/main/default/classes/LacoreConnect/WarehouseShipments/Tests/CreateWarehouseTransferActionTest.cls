@IsTest
private class CreateWarehouseTransferActionTest {
    @IsTest
    static void testCreateWarehouseTransferSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Transfer';
        mockResponse.type = 1; // Transfer type
        mockResponse.status = 'Pending';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test Transfer';
        shipment.fromWarehouseId = 1;
        shipment.toWarehouseId = 2;
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
    static void testCreateWarehouseTransferError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
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