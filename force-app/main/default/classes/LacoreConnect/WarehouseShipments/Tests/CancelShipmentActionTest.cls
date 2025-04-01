@IsTest
private class CancelShipmentActionTest {
    @IsTest
    static void testCancelShipmentSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'Cancelled';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        WarehouseShipmentCancelReq cancelRequest = new WarehouseShipmentCancelReq();
        cancelRequest.note = 'Test cancellation note';
        
        CancelShipmentAction.CancelShipmentRequest request = new CancelShipmentAction.CancelShipmentRequest();
        request.id = 1;
        request.cancelRequest = cancelRequest;
        
        // Execute the action
        List<CancelShipmentAction.CancelShipmentResponse> responses = 
            CancelShipmentAction.execute(new List<CancelShipmentAction.CancelShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CancelShipmentAction.CancelShipmentResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('Cancelled', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    static void testCancelShipmentError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        WarehouseShipmentCancelReq cancelRequest = new WarehouseShipmentCancelReq();
        cancelRequest.note = 'Test cancellation note';
        
        CancelShipmentAction.CancelShipmentRequest request = new CancelShipmentAction.CancelShipmentRequest();
        request.id = 1;
        request.cancelRequest = cancelRequest;
        
        // Execute the action
        List<CancelShipmentAction.CancelShipmentResponse> responses = 
            CancelShipmentAction.execute(new List<CancelShipmentAction.CancelShipmentRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CancelShipmentAction.CancelShipmentResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 