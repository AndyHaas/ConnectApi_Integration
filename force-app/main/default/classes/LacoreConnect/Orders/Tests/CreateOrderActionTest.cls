@IsTest
private class CreateOrderActionTest {
    private static final String TEST_ORDER_ID = 'test-order-id';
    private static final String TEST_STOREFRONT_ID = 'test-storefront-id';
    private static final String TEST_CUSTOMER_EMAIL = 'test@example.com';
    
    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    static void testCreateOrder() {
        Test.startTest();
        
        CreateOrderAction.CreateOrderRequest request = new CreateOrderAction.CreateOrderRequest();
        request.isUpdate = false;
        request.isBulkOperation = false;
        
        CreateOrderAction.OrderRequestData orderData = new CreateOrderAction.OrderRequestData();
        orderData.orderId = TEST_ORDER_ID;
        orderData.orderNumber = 'TEST-ORDER-001';
        orderData.orderStatus = 'DRAFT';
        orderData.customerEmail = TEST_CUSTOMER_EMAIL;
        orderData.storefrontId = TEST_STOREFRONT_ID;
        orderData.paymentMethod = 'CREDIT_CARD';
        orderData.orderTotal = 100.00;
        
        AddressDto billTo = new AddressDto();
        billTo.name = 'John Doe';
        billTo.address1 = '123 Test St';
        billTo.city = 'Test City';
        billTo.state = 'TS';
        billTo.zip = '12345';
        billTo.country = 'US';
        billTo.email = TEST_CUSTOMER_EMAIL;
        orderData.billTo = billTo;
        
        AddressDto shipTo = new AddressDto();
        shipTo.name = 'John Doe';
        shipTo.address1 = '123 Test St';
        shipTo.city = 'Test City';
        shipTo.state = 'TS';
        shipTo.zip = '12345';
        shipTo.country = 'US';
        shipTo.email = TEST_CUSTOMER_EMAIL;
        orderData.shipTo = shipTo;
        
        OrderItemDto item = new OrderItemDto();
        item.sku = 'TEST-SKU-001';
        item.name = 'Test Item';
        item.quantity = 1;
        item.price = 100.00;
        item.weight = 1.0;
        item.weightUnit = 'lb';
        item.metadata = new Map<String, Object>();
        orderData.items = new List<OrderItemDto>{item};
        
        request.order = orderData;
        
        List<CreateOrderAction.CreateOrderResponse> responses = 
            CreateOrderAction.execute(new List<CreateOrderAction.CreateOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
    
    @IsTest
    static void testCreateOrderError() {
        Test.startTest();
        
        // Set up mock to return error
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"message":"Invalid order data"}'));
        
        CreateOrderAction.CreateOrderRequest request = new CreateOrderAction.CreateOrderRequest();
        request.isUpdate = false;
        request.isBulkOperation = false;
        
        CreateOrderAction.OrderRequestData orderData = new CreateOrderAction.OrderRequestData();
        orderData.orderId = TEST_ORDER_ID;
        orderData.orderNumber = 'TEST-ORDER-001';
        orderData.orderStatus = 'DRAFT';
        orderData.customerEmail = TEST_CUSTOMER_EMAIL;
        orderData.storefrontId = TEST_STOREFRONT_ID;
        orderData.paymentMethod = 'CREDIT_CARD';
        orderData.orderTotal = 100.00;
        
        AddressDto billTo = new AddressDto();
        billTo.name = 'John Doe';
        billTo.address1 = '123 Test St';
        billTo.city = 'Test City';
        billTo.state = 'TS';
        billTo.zip = '12345';
        billTo.country = 'US';
        billTo.email = TEST_CUSTOMER_EMAIL;
        orderData.billTo = billTo;
        
        AddressDto shipTo = new AddressDto();
        shipTo.name = 'John Doe';
        shipTo.address1 = '123 Test St';
        shipTo.city = 'Test City';
        shipTo.state = 'TS';
        shipTo.zip = '12345';
        shipTo.country = 'US';
        shipTo.email = TEST_CUSTOMER_EMAIL;
        orderData.shipTo = shipTo;
        
        OrderItemDto item = new OrderItemDto();
        item.sku = 'TEST-SKU-001';
        item.name = 'Test Item';
        item.quantity = 1;
        item.price = 100.00;
        item.weight = 1.0;
        item.weightUnit = 'lb';
        item.metadata = new Map<String, Object>();
        orderData.items = new List<OrderItemDto>{item};
        
        request.order = orderData;
        
        List<CreateOrderAction.CreateOrderResponse> responses = 
            CreateOrderAction.execute(new List<CreateOrderAction.CreateOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(false, responses[0].success, 'Expected error response');
        System.assertEquals('Invalid order data', responses[0].message, 'Expected error message');
    }
    
    @IsTest
    static void testCreateOrderBulk() {
        Test.startTest();
        
        CreateOrderAction.CreateOrderRequest request = new CreateOrderAction.CreateOrderRequest();
        request.isUpdate = false;
        request.isBulkOperation = true;
        
        List<CreateOrderAction.OrderRequestData> orders = new List<CreateOrderAction.OrderRequestData>();
        
        // Create first order
        CreateOrderAction.OrderRequestData order1 = new CreateOrderAction.OrderRequestData();
        order1.orderId = TEST_ORDER_ID + '1';
        order1.orderNumber = 'TEST-ORDER-001';
        order1.orderStatus = 'DRAFT';
        order1.customerEmail = TEST_CUSTOMER_EMAIL;
        order1.storefrontId = TEST_STOREFRONT_ID;
        order1.paymentMethod = 'CREDIT_CARD';
        order1.orderTotal = 100.00;
        
        AddressDto billTo1 = new AddressDto();
        billTo1.name = 'John Doe';
        billTo1.address1 = '123 Test St';
        billTo1.city = 'Test City';
        billTo1.state = 'TS';
        billTo1.zip = '12345';
        billTo1.country = 'US';
        billTo1.email = TEST_CUSTOMER_EMAIL;
        order1.billTo = billTo1;
        
        AddressDto shipTo1 = new AddressDto();
        shipTo1.name = 'John Doe';
        shipTo1.address1 = '123 Test St';
        shipTo1.city = 'Test City';
        shipTo1.state = 'TS';
        shipTo1.zip = '12345';
        shipTo1.country = 'US';
        shipTo1.email = TEST_CUSTOMER_EMAIL;
        order1.shipTo = shipTo1;
        
        OrderItemDto item1 = new OrderItemDto();
        item1.sku = 'TEST-SKU-001';
        item1.name = 'Test Item';
        item1.quantity = 1;
        item1.price = 100.00;
        item1.weight = 1.0;
        item1.weightUnit = 'lb';
        item1.metadata = new Map<String, Object>();
        order1.items = new List<OrderItemDto>{item1};
        
        orders.add(order1);
        
        // Create second order
        CreateOrderAction.OrderRequestData order2 = new CreateOrderAction.OrderRequestData();
        order2.orderId = TEST_ORDER_ID + '2';
        order2.orderNumber = 'TEST-ORDER-002';
        order2.orderStatus = 'DRAFT';
        order2.customerEmail = TEST_CUSTOMER_EMAIL;
        order2.storefrontId = TEST_STOREFRONT_ID;
        order2.paymentMethod = 'CREDIT_CARD';
        order2.orderTotal = 200.00;
        
        AddressDto billTo2 = new AddressDto();
        billTo2.name = 'Jane Doe';
        billTo2.address1 = '456 Test St';
        billTo2.city = 'Test City';
        billTo2.state = 'TS';
        billTo2.zip = '12345';
        billTo2.country = 'US';
        billTo2.email = TEST_CUSTOMER_EMAIL;
        order2.billTo = billTo2;
        
        AddressDto shipTo2 = new AddressDto();
        shipTo2.name = 'Jane Doe';
        shipTo2.address1 = '456 Test St';
        shipTo2.city = 'Test City';
        shipTo2.state = 'TS';
        shipTo2.zip = '12345';
        shipTo2.country = 'US';
        shipTo2.email = TEST_CUSTOMER_EMAIL;
        order2.shipTo = shipTo2;
        
        OrderItemDto item2 = new OrderItemDto();
        item2.sku = 'TEST-SKU-002';
        item2.name = 'Test Item 2';
        item2.quantity = 2;
        item2.price = 100.00;
        item2.weight = 1.0;
        item2.weightUnit = 'lb';
        item2.metadata = new Map<String, Object>();
        order2.items = new List<OrderItemDto>{item2};
        
        orders.add(order2);
        
        request.orders = orders;
        
        List<CreateOrderAction.CreateOrderResponse> responses = 
            CreateOrderAction.execute(new List<CreateOrderAction.CreateOrderRequest>{request});
        
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Expected one response');
        System.assertEquals(true, responses[0].success, 'Expected success response');
    }
} 