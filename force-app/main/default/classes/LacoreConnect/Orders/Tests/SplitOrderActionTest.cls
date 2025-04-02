/**
 * @description Test class for SplitOrderAction.
 * This class provides test coverage for the SplitOrderAction class,
 * including successful and error scenarios.
 */
@IsTest
public class SplitOrderActionTest {
    private static final String TEST_ORDER_ID = 'test-order-id';
    
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testSplitOrder() {
        Test.startTest();
        
        SplitOrderAction.SplitOrderRequest request = new SplitOrderAction.SplitOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<SplitOrderAction.SplitOrderResponse> responses = 
            SplitOrderAction.execute(new List<SplitOrderAction.SplitOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
    
    @IsTest
    public static void testSplitOrderError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Order cannot be split"}'));
        
        SplitOrderAction.SplitOrderRequest request = new SplitOrderAction.SplitOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<SplitOrderAction.SplitOrderResponse> responses = 
            SplitOrderAction.execute(new List<SplitOrderAction.SplitOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].success, 'Expected error response');
        System.assertEquals('Order cannot be split', responses[0].message, 'Expected error message');
    }
    
    @IsTest
    public static void testSplitOrderMultiple() {
        Test.startTest();
        
        List<SplitOrderAction.SplitOrderRequest> requests = new List<SplitOrderAction.SplitOrderRequest>();
        
        // Create first request
        SplitOrderAction.SplitOrderRequest request1 = new SplitOrderAction.SplitOrderRequest();
        request1.orderId = TEST_ORDER_ID + '1';
        requests.add(request1);
        
        // Create second request
        SplitOrderAction.SplitOrderRequest request2 = new SplitOrderAction.SplitOrderRequest();
        request2.orderId = TEST_ORDER_ID + '2';
        requests.add(request2);
        
        List<SplitOrderAction.SplitOrderResponse> responses = SplitOrderAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].success, 'Expected success response for first request');
        System.assertEquals(true, responses[1].success, 'Expected success response for second request');
    }
} 