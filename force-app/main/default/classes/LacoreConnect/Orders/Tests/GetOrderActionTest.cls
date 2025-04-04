/**
 * @description Test class for GetOrderAction.
 * This class provides test coverage for the GetOrderAction class,
 * including successful and error scenarios.
 */
@IsTest
public class GetOrderActionTest {
    /** Test order ID used in test methods */
    private static final String TEST_ORDER_ID = 'test-order-id';
    
    /**
     * @description Test setup method that configures the test environment
     */
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    /**
     * @description Tests successful order retrieval
     */
    @IsTest
    public static void testGetOrder() {
        Test.startTest();
        
        GetOrderAction.GetOrderRequest request = new GetOrderAction.GetOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<GetOrderAction.GetOrderResponse> responses = 
            GetOrderAction.execute(new List<GetOrderAction.GetOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
    
    /**
     * @description Tests error handling when order retrieval fails
     */
    @IsTest
    public static void testGetOrderError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Order not found"}'));
        
        GetOrderAction.GetOrderRequest request = new GetOrderAction.GetOrderRequest();
        request.orderId = TEST_ORDER_ID;
        
        List<GetOrderAction.GetOrderResponse> responses = 
            GetOrderAction.execute(new List<GetOrderAction.GetOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].success, 'Expected error response');
        System.assertEquals('Order not found', responses[0].message, 'Expected error message');
    }
    
    @IsTest
    public static void testGetOrderMultiple() {
        Test.startTest();
        
        List<GetOrderAction.GetOrderRequest> requests = new List<GetOrderAction.GetOrderRequest>();
        
        // Create first request
        GetOrderAction.GetOrderRequest request1 = new GetOrderAction.GetOrderRequest();
        request1.orderId = TEST_ORDER_ID + '1';
        requests.add(request1);
        
        // Create second request
        GetOrderAction.GetOrderRequest request2 = new GetOrderAction.GetOrderRequest();
        request2.orderId = TEST_ORDER_ID + '2';
        requests.add(request2);
        
        List<GetOrderAction.GetOrderResponse> responses = GetOrderAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].success, 'Expected success response for first request');
        System.assertEquals(true, responses[1].success, 'Expected success response for second request');
    }
} 