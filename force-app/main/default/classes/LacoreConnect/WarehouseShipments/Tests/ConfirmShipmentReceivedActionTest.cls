@IsTest
private class ConfirmShipmentReceivedActionTest {
    @IsTest
    static void testConfirmShipmentReceivedSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'Received';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
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
        request.id = 1;
        request.confirmation = confirmation;
        
        // Execute the action
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
    static void testConfirmShipmentReceivedError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        WarehouseShipmentConfirmReceivedReq confirmation = new WarehouseShipmentConfirmReceivedReq();
        confirmation.note = 'Test confirmation';
        
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest request = new ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest();
        request.id = 1;
        request.confirmation = confirmation;
        
        // Execute the action
        List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse> responses = 
            ConfirmShipmentReceivedAction.execute(new List<ConfirmShipmentReceivedAction.ConfirmShipmentReceivedRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        ConfirmShipmentReceivedAction.ConfirmShipmentReceivedResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 