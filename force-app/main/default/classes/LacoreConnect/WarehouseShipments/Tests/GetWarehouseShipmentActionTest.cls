@IsTest
private class GetWarehouseShipmentActionTest {
    @IsTest
    static void testGetWarehouseShipmentSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'Pending';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        GetWarehouseShipmentAction.GetWarehouseShipmentRequest request = new GetWarehouseShipmentAction.GetWarehouseShipmentRequest();
        request.id = 1;
        
        // Execute the action
        List<GetWarehouseShipmentAction.GetWarehouseShipmentResponse> responses = 
            GetWarehouseShipmentAction.execute(new List<GetWarehouseShipmentAction.GetWarehouseShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        GetWarehouseShipmentAction.GetWarehouseShipmentResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Pending', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    static void testGetWarehouseShipmentError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        GetWarehouseShipmentAction.GetWarehouseShipmentRequest request = new GetWarehouseShipmentAction.GetWarehouseShipmentRequest();
        request.id = 1;
        
        // Execute the action
        List<GetWarehouseShipmentAction.GetWarehouseShipmentResponse> responses = 
            GetWarehouseShipmentAction.execute(new List<GetWarehouseShipmentAction.GetWarehouseShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        GetWarehouseShipmentAction.GetWarehouseShipmentResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 