/**
 * @description Test class for CancelOrderAction.
 * This class provides test coverage for the CancelOrderAction class,
 * including successful and error scenarios.
 */
@IsTest
public class CancelOrderActionTest {
    /** Test order ID used in test methods */
    private static final String TEST_ORDER_ID = 'test-order-id';
    /** Test cancellation reason used in test methods */
    private static final String TEST_REASON = 'Customer requested cancellation';
    
    /**
     * @description Test setup method that configures the test environment
     */
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    /**
     * @description Tests successful order cancellation
     */
    @IsTest
    public static void testCancelOrder() {
        Test.startTest();
        
        CancelOrderAction.CancelOrderRequest request = new CancelOrderAction.CancelOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<CancelOrderAction.CancelOrderResponse> responses = 
            CancelOrderAction.execute(new List<CancelOrderAction.CancelOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
    
    /**
     * @description Tests error handling when order cancellation fails
     */
    @IsTest
    public static void testCancelOrderError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Order cannot be cancelled"}'));
        
        CancelOrderAction.CancelOrderRequest request = new CancelOrderAction.CancelOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<CancelOrderAction.CancelOrderResponse> responses = 
            CancelOrderAction.execute(new List<CancelOrderAction.CancelOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].success, 'Expected error response');
        System.assertEquals('Order cannot be cancelled', responses[0].message, 'Expected error message');
    }
    
    /**
     * @description Tests handling multiple order cancellations
     */
    @IsTest
    public static void testCancelOrderMultiple() {
        Test.startTest();
        
        List<CancelOrderAction.CancelOrderRequest> requests = new List<CancelOrderAction.CancelOrderRequest>();
        
        // Create first request
        CancelOrderAction.CancelOrderRequest request1 = new CancelOrderAction.CancelOrderRequest();
        request1.orderId = TEST_ORDER_ID + '1';
        requests.add(request1);
        
        // Create second request
        CancelOrderAction.CancelOrderRequest request2 = new CancelOrderAction.CancelOrderRequest();
        request2.orderId = TEST_ORDER_ID + '2';
        requests.add(request2);
        
        List<CancelOrderAction.CancelOrderResponse> responses = CancelOrderAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].success, 'Expected success response for first request');
        System.assertEquals(true, responses[1].success, 'Expected success response for second request');
    }
} 