/**
 * @description Test class for ListOrdersAction.
 * This class provides test coverage for the ListOrdersAction class,
 * including successful and error scenarios.
 */
@IsTest
public class ListOrdersActionTest {
    /** Test storefront ID used in test methods */
    private static final String TEST_STOREFRONT_ID = 'test-storefront-id';
    
    /**
     * @description Test setup method that configures the test environment
     */
    @TestSetup
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    /**
     * @description Tests successful order listing
     */
    @IsTest
    public static void testListOrders() {
        Test.startTest();
        
        ListOrdersAction.ListOrdersRequest request = new ListOrdersAction.ListOrdersRequest();
        request.storefrontId = TEST_STOREFRONT_ID;
        request.sortBy = 'createdAt';
        request.sortDir = 'desc';
        request.createdDateStart = Date.today();
        request.createdDateEnd = Date.today();
        request.orderDateStart = Date.today();
        request.orderDateEnd = Date.today();
        request.orderNumber = '1234567890';
        
        List<ListOrdersAction.ListOrdersResponse> responses = 
            ListOrdersAction.execute(new List<ListOrdersAction.ListOrdersRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testListOrdersError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Invalid request"}'));
        
        ListOrdersAction.ListOrdersRequest request = new ListOrdersAction.ListOrdersRequest();
        request.storefrontId = TEST_STOREFRONT_ID;
        request.sortBy = 'createdAt';
        request.sortDir = 'desc';
        request.createdDateStart = Date.today();
        request.createdDateEnd = Date.today();
        request.orderDateStart = Date.today();
        request.orderDateEnd = Date.today();
        
        List<ListOrdersAction.ListOrdersResponse> responses = 
            ListOrdersAction.execute(new List<ListOrdersAction.ListOrdersRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].isSuccess, 'Expected error response');
        System.assertEquals('Invalid request', responses[0].errorMessage, 'Expected error message');
    }
    
    @IsTest
    public static void testListOrdersMultiple() {
        Test.startTest();
        
        List<ListOrdersAction.ListOrdersRequest> requests = new List<ListOrdersAction.ListOrdersRequest>();
        
        // Create first request
        ListOrdersAction.ListOrdersRequest request1 = new ListOrdersAction.ListOrdersRequest();
        request1.storefrontId = TEST_STOREFRONT_ID;
        request1.sortBy = 'createdAt';
        request1.sortDir = 'desc';
        request1.createdDateStart = Date.today();
        request1.createdDateEnd = Date.today();
        request1.orderDateStart = Date.today();
        request1.orderDateEnd = Date.today();
        
        // Create second request
        ListOrdersAction.ListOrdersRequest request2 = new ListOrdersAction.ListOrdersRequest();
        request2.storefrontId = TEST_STOREFRONT_ID;
        request2.sortBy = 'createdAt';
        request2.sortDir = 'desc';
        request2.createdDateStart = Date.today();
        request2.createdDateEnd = Date.today();
        request2.orderDateStart = Date.today();
        request2.orderDateEnd = Date.today();
        
        List<ListOrdersAction.ListOrdersResponse> responses = ListOrdersAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response for first request');
        System.assertEquals(true, responses[1].isSuccess, 'Expected success response for second request');
    }
} 