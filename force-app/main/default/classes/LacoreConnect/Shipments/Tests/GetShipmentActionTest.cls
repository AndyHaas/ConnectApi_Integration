@IsTest
private class GetShipmentActionTest {
    
    @TestSetup
    static void setup() {
        // Create test data
    }
    
    @IsTest
    static void testGetShipment() {
        // Prepare test request
        GetShipmentAction.GetShipmentRequest request = new GetShipmentAction.GetShipmentRequest();
        request.id = 'test-shipment-id';
        
        // Execute test
        Test.startTest();
        List<GetShipmentAction.GetShipmentResponse> responses = 
            GetShipmentAction.execute(new List<GetShipmentAction.GetShipmentRequest>{ request });
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, responses.size(), 'Should have one response');
        GetShipmentAction.GetShipmentResponse response = responses[0];
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertNotEquals(null, response.data, 'Response data should not be null');
    }
    
    @IsTest
    static void testErrorHandling() {
        Test.startTest();
        
        // Create test request with missing required fields
        GetShipmentAction.GetShipmentRequest request = new GetShipmentAction.GetShipmentRequest();
        
        // Call action
        List<GetShipmentAction.GetShipmentResponse> responses = 
            GetShipmentAction.execute(new List<GetShipmentAction.GetShipmentRequest>{ request });
        
        // Verify error response
        System.assertEquals(1, responses.size(), 'Should have one response');
        System.assertEquals(false, responses[0].success, 'Response should not be successful');
        System.assertNotEquals(null, responses[0].message, 'Error message should not be null');
        
        Test.stopTest();
    }
} 