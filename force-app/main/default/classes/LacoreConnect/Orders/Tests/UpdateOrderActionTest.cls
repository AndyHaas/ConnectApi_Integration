@IsTest
private class UpdateOrderActionTest {
    private static final String TEST_ORDER_ID = 'test-order-id';
    private static final String TEST_BRAND_ID = 'test-brand-id';
    private static final String TEST_CUSTOMER_ID = 'test-customer-id';
    private static final String TEST_SKU = 'test-sku';
    private static final String TEST_CUSTOMER_NAME = 'Test Customer';
    private static final String TEST_CUSTOMER_EMAIL = 'test@example.com';
    
    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    static void testUpdateOrder() {
        Test.startTest();
        
        UpdateOrderAction.UpdateOrderRequest request = new UpdateOrderAction.UpdateOrderRequest();
        request.id = TEST_ORDER_ID;
        request.brandId = TEST_BRAND_ID;
        request.customerId = TEST_CUSTOMER_ID;
        request.customerName = TEST_CUSTOMER_NAME;
        request.customerEmail = TEST_CUSTOMER_EMAIL;
        
        UpdateOrderAction.OrderItem item = new UpdateOrderAction.OrderItem();
        item.item = TEST_SKU;
        item.quantity = 1;
        request.items = new List<UpdateOrderAction.OrderItem>{item};
        
        request.shippingAddress = new AddressDto();
        
        List<LacoreConnectService.ApiResponse> responses = 
            UpdateOrderAction.execute(new List<UpdateOrderAction.UpdateOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testUpdateOrderError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Invalid order"}'));
        
        UpdateOrderAction.UpdateOrderRequest request = new UpdateOrderAction.UpdateOrderRequest();
        request.id = TEST_ORDER_ID;
        request.brandId = TEST_BRAND_ID;
        request.customerId = TEST_CUSTOMER_ID;
        request.customerName = TEST_CUSTOMER_NAME;
        request.customerEmail = TEST_CUSTOMER_EMAIL;
        
        UpdateOrderAction.OrderItem item = new UpdateOrderAction.OrderItem();
        item.item = TEST_SKU;
        item.quantity = 1;
        request.items = new List<UpdateOrderAction.OrderItem>{item};
        
        request.shippingAddress = new AddressDto();
        
        List<LacoreConnectService.ApiResponse> responses = 
            UpdateOrderAction.execute(new List<UpdateOrderAction.UpdateOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].isSuccess, 'Expected error response');
        System.assertEquals('Invalid order', responses[0].errorMessage, 'Expected error message');
    }
    
    @IsTest
    static void testUpdateOrderMultiple() {
        Test.startTest();
        
        List<UpdateOrderAction.UpdateOrderRequest> requests = new List<UpdateOrderAction.UpdateOrderRequest>();
        
        // Create first request
        UpdateOrderAction.UpdateOrderRequest request1 = new UpdateOrderAction.UpdateOrderRequest();
        request1.id = TEST_ORDER_ID + '1';
        request1.brandId = TEST_BRAND_ID;
        request1.customerId = TEST_CUSTOMER_ID + '1';
        request1.customerName = TEST_CUSTOMER_NAME + '1';
        request1.customerEmail = TEST_CUSTOMER_EMAIL;
        
        UpdateOrderAction.OrderItem item1 = new UpdateOrderAction.OrderItem();
        item1.item = TEST_SKU + '1';
        item1.quantity = 1;
        request1.items = new List<UpdateOrderAction.OrderItem>{item1};
        
        request1.shippingAddress = new AddressDto();
        requests.add(request1);
        
        // Create second request
        UpdateOrderAction.UpdateOrderRequest request2 = new UpdateOrderAction.UpdateOrderRequest();
        request2.id = TEST_ORDER_ID + '2';
        request2.brandId = TEST_BRAND_ID;
        request2.customerId = TEST_CUSTOMER_ID + '2';
        request2.customerName = TEST_CUSTOMER_NAME + '2';
        request2.customerEmail = TEST_CUSTOMER_EMAIL;
        
        UpdateOrderAction.OrderItem item2 = new UpdateOrderAction.OrderItem();
        item2.item = TEST_SKU + '2';
        item2.quantity = 1;
        request2.items = new List<UpdateOrderAction.OrderItem>{item2};
        
        request2.shippingAddress = new AddressDto();
        requests.add(request2);
        
        List<LacoreConnectService.ApiResponse> responses = UpdateOrderAction.execute(requests);
        
        Test.stopTest();
        
        System.assertEquals(2, responses.size(), 'Expected two responses');
        System.assertEquals(true, responses[0].isSuccess, 'Expected success response for first request');
        System.assertEquals(true, responses[1].isSuccess, 'Expected success response for second request');
    }
} 