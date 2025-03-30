@IsTest
private class ListOrdersActionTest {
    private static final String TEST_BRAND_ID = 'test-brand-id';
    private static final String TEST_CUSTOMER_ID = 'test-customer-id';
    private static final String TEST_STATUS = 'DRAFT';
    
    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    static void testListOrders() {
        Test.startTest();
        
        ListOrdersAction.ListOrdersRequest request = new ListOrdersAction.ListOrdersRequest();
        request.brandId = TEST_BRAND_ID;
        request.customerId = TEST_CUSTOMER_ID;
        request.status = TEST_STATUS;
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'createdAt';
        request.sortDir = 'desc';
        
        List<ListOrdersAction.ListOrdersResponse> responses = 
            ListOrdersAction.execute(new List<ListOrdersAction.ListOrdersRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListOrdersError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Invalid request"}'));
        
        ListOrdersAction.ListOrdersRequest request = new ListOrdersAction.ListOrdersRequest();
        request.brandId = TEST_BRAND_ID;
        request.customerId = TEST_CUSTOMER_ID;
        request.status = TEST_STATUS;
        request.page = 1;
        request.pageSize = 10;
        request.sortBy = 'createdAt';
        request.sortDir = 'desc';
        
        List<ListOrdersAction.ListOrdersResponse> responses = 
            ListOrdersAction.execute(new List<ListOrdersAction.ListOrdersRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].isSuccess, 'Expected error response');
        System.assertEquals('Invalid request', responses[0].errorMessage, 'Expected error message');
    }
    
    @IsTest
    static void testListOrdersMultiple() {
        Test.startTest();
        
        List<ListOrdersAction.ListOrdersRequest> requests = new List<ListOrdersAction.ListOrdersRequest>();
        
        // Create first request
        ListOrdersAction.ListOrdersRequest request1 = new ListOrdersAction.ListOrdersRequest();
        request1.brandId = TEST_BRAND_ID + '1';
        request1.customerId = TEST_CUSTOMER_ID + '1';
        request1.status = TEST_STATUS;
        request1.page = 1;
        request1.pageSize = 10;
        request1.sortBy = 'createdAt';
        request1.sortDir = 'desc';
        requests.add(request1);
        
        // Create second request
        ListOrdersAction.ListOrdersRequest request2 = new ListOrdersAction.ListOrdersRequest();
        request2.brandId = TEST_BRAND_ID + '2';
        request2.customerId = TEST_CUSTOMER_ID + '2';
        request2.status = TEST_STATUS;
        request2.page = 1;
        request2.pageSize = 10;
        request2.sortBy = 'createdAt';
        request2.sortDir = 'desc';
        requests.add(request2);
        
        List<ListOrdersAction.ListOrdersResponse> responses = ListOrdersAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response for first request');
        System.assertEquals(true, responses[1].isSuccess, 'Expected success response for second request');
    }
} 