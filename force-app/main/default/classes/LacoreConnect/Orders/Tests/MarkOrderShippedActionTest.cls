@IsTest
private class MarkOrderShippedActionTest {
    private static final String TEST_ORDER_ID = 'test-order-id';
    private static final String TEST_TRACKING_NUMBER = 'test-tracking-number';
    private static final String TEST_CARRIER = 'test-carrier';
    
    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    static void testMarkOrderShipped() {
        Test.startTest();
        
        MarkOrderShippedAction.MarkOrderShippedRequest request = new MarkOrderShippedAction.MarkOrderShippedRequest();
        request.orderId = TEST_ORDER_ID;
        request.trackingNumber = TEST_TRACKING_NUMBER;
        request.carrier = TEST_CARRIER;
        
        List<MarkOrderShippedAction.MarkOrderShippedResponse> responses = 
            MarkOrderShippedAction.execute(new List<MarkOrderShippedAction.MarkOrderShippedRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
    
    @IsTest
    static void testMarkOrderShippedError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Invalid order"}'));
        
        MarkOrderShippedAction.MarkOrderShippedRequest request = new MarkOrderShippedAction.MarkOrderShippedRequest();
        request.orderId = TEST_ORDER_ID;
        request.trackingNumber = TEST_TRACKING_NUMBER;
        request.carrier = TEST_CARRIER;
        
        List<MarkOrderShippedAction.MarkOrderShippedResponse> responses = 
            MarkOrderShippedAction.execute(new List<MarkOrderShippedAction.MarkOrderShippedRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].success, 'Expected error response');
        System.assertEquals('Invalid order', responses[0].message, 'Expected error message');
    }
    
    @IsTest
    static void testMarkOrderShippedMultiple() {
        Test.startTest();
        
        List<MarkOrderShippedAction.MarkOrderShippedRequest> requests = new List<MarkOrderShippedAction.MarkOrderShippedRequest>();
        
        // Create first request
        MarkOrderShippedAction.MarkOrderShippedRequest request1 = new MarkOrderShippedAction.MarkOrderShippedRequest();
        request1.orderId = TEST_ORDER_ID + '1';
        request1.trackingNumber = TEST_TRACKING_NUMBER + '1';
        request1.carrier = TEST_CARRIER;
        requests.add(request1);
        
        // Create second request
        MarkOrderShippedAction.MarkOrderShippedRequest request2 = new MarkOrderShippedAction.MarkOrderShippedRequest();
        request2.orderId = TEST_ORDER_ID + '2';
        request2.trackingNumber = TEST_TRACKING_NUMBER + '2';
        request2.carrier = TEST_CARRIER;
        requests.add(request2);
        
        List<MarkOrderShippedAction.MarkOrderShippedResponse> responses = MarkOrderShippedAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].success, 'Expected success response for first request');
        System.assertEquals(true, responses[1].success, 'Expected success response for second request');
    }
} 