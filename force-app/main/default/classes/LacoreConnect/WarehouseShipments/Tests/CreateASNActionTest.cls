@IsTest
private class CreateASNActionTest {
    @IsTest
    static void testCreateASNSuccess() {
        // Create test data
        WarehouseShipmentDto mockResponse = new WarehouseShipmentDto();
        mockResponse.id = '1';
        mockResponse.name = 'Test ASN';
        mockResponse.type = 2; // ASN type
        mockResponse.status = 'Pending';
        
        // Create a mock for LacoreConnectService
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(mockResponse));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test ASN';
        shipment.vendorId = 1;
        shipment.toWarehouseId = 2;
        shipment.type = 'ASN';
        
        CreateASNAction.CreateASNRequest request = new CreateASNAction.CreateASNRequest();
        request.shipment = shipment;
        
        // Execute the action
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
    static void testCreateASNError() {
        // Create a mock for LacoreConnectService that throws an exception
        Test.startTest();
        LacoreConnectService.setMock(new LacoreConnectServiceMock(new CalloutException('Test error')));
        
        // Create request
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.name = 'Test ASN';
        
        CreateASNAction.CreateASNRequest request = new CreateASNAction.CreateASNRequest();
        request.shipment = shipment;
        
        // Execute the action
        List<CreateASNAction.CreateASNResponse> responses = 
            CreateASNAction.execute(new List<CreateASNAction.CreateASNRequest>{request});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should return one response');
        CreateASNAction.CreateASNResponse response = responses[0];
        System.assert(!response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Should return correct error message');
    }
} 