@IsTest
private class MarkShipmentInTransitActionTest {
    @IsTest
    static void testMarkShipmentInTransitSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test Shipment';
        mockResponse.status = 'In Transit';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        WarehouseShipmentMarkInTransitReq transitRequest = new WarehouseShipmentMarkInTransitReq();
        transitRequest.note = 'Test transit note';
        
        MarkShipmentInTransitAction.MarkShipmentInTransitRequest request = new MarkShipmentInTransitAction.MarkShipmentInTransitRequest();
        request.id = 1;
        request.transitRequest = transitRequest;
        
        // Execute the action
        List<MarkShipmentInTransitAction.MarkShipmentInTransitResponse> responses = 
            MarkShipmentInTransitAction.execute(new List<MarkShipmentInTransitAction.MarkShipmentInTransitRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        MarkShipmentInTransitAction.MarkShipmentInTransitResponse response = responses[0];
        System.assert(response.isSuccess, 'Response should be successful');
        System.assertEquals('Test Shipment', response.shipment.name, 'Should return correct shipment name');
        System.assertEquals('In Transit', response.shipment.status, 'Should return correct shipment status');
    }
    
    @IsTest
    static void testMarkShipmentInTransitError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        WarehouseShipmentMarkInTransitReq transitRequest = new WarehouseShipmentMarkInTransitReq();
        transitRequest.note = 'Test transit note';
        
        MarkShipmentInTransitAction.MarkShipmentInTransitRequest request = new MarkShipmentInTransitAction.MarkShipmentInTransitRequest();
        request.id = 1;
        request.transitRequest = transitRequest;
        
        // Execute the action
        List<MarkShipmentInTransitAction.MarkShipmentInTransitResponse> responses = 
            MarkShipmentInTransitAction.execute(new List<MarkShipmentInTransitAction.MarkShipmentInTransitRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        MarkShipmentInTransitAction.MarkShipmentInTransitResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 