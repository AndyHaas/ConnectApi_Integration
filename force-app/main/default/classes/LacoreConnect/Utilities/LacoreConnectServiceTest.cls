@IsTest
private without sharing class LacoreConnectServiceTest {
    private static final String TEST_BRAND_ID = 'test-brand-id';
    private static final String TEST_WAREHOUSE_ID = 'test-warehouse-id';
    private static final String TEST_ORDER_ID = 'test-order-id';
    private static final String TEST_WEBHOOK_ID = 'test-webhook-id';
    private static final String TEST_CUSTOMER_ID = 'test-customer-id';
    private static final String TEST_STOREFRONT_ID = 'test-storefront-id';
    private static final String TEST_STATUS = 'test-status';
    private static final String TEST_WEBHOOK_URL = 'https://test.com/webhook';
    private static final String TEST_WEBHOOK_EVENT = 'order.created';
    private static final String TEST_WEBHOOK_NAME = 'Test Webhook';
    private static final String TEST_TRACKING_NUMBER = 'test-tracking-number';
    private static final String TEST_CARRIER = 'test-carrier';
    
    @TestSetup
    static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    static void testCreateOrder() {
        Test.startTest();
        
        OrderDto order = new OrderDto();
        order.orderNumber = 'TEST-ORDER-001';
        order.orderDateTimeUtc = System.now();
        order.orderStatus = 'DRAFT';
        order.orderTotal = 100.00;
        order.taxAmount = 10.00;
        order.shippingAmount = 5.00;
        order.customerNotes = 'Test order';
        order.storefrontId = TEST_STOREFRONT_ID;
        order.customerEmail = 'test@example.com';
        order.customerUsername = 'testuser';
        
        AddressDto billTo = new AddressDto();
        billTo.name = 'John Doe';
        billTo.company = 'Test Company';
        billTo.address1 = '123 Test St';
        billTo.city = 'Test City';
        billTo.state = 'TS';
        billTo.zip = '12345';
        billTo.country = 'US';
        billTo.phone = '555-555-5555';
        billTo.email = 'test@example.com';
        order.billTo = billTo;
        
        AddressDto shipTo = new AddressDto();
        shipTo.name = 'John Doe';
        shipTo.company = 'Test Company';
        shipTo.address1 = '123 Test St';
        shipTo.city = 'Test City';
        shipTo.state = 'TS';
        shipTo.zip = '12345';
        shipTo.country = 'US';
        shipTo.phone = '555-555-5555';
        shipTo.email = 'test@example.com';
        order.shipTo = shipTo;
        
        OrderItemDto item = new OrderItemDto();
        item.sku = 'TEST-SKU-001';
        item.name = 'Test Item';
        item.quantity = 1;
        item.price = 100.00;
        item.weight = 1.0;
        item.weightUnit = 'lb';
        item.metadata = new Map<String, Object>();
        order.items = new List<OrderItemDto>{item};
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createOrder(order);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testUpdateOrder() {
        Test.startTest();
        
        OrderDto order = new OrderDto();
        order.orderId = TEST_ORDER_ID;
        order.orderNumber = 'TEST-ORDER-001';
        order.orderDateTimeUtc = System.now();
        order.orderStatus = 'PROCESSING';
        order.orderTotal = 100.00;
        order.taxAmount = 10.00;
        order.shippingAmount = 5.00;
        order.customerNotes = 'Updated test order';
        order.storefrontId = TEST_STOREFRONT_ID;
        order.customerEmail = 'test@example.com';
        order.customerUsername = 'testuser';
        
        AddressDto billTo = new AddressDto();
        billTo.name = 'John Doe';
        billTo.company = 'Test Company';
        billTo.address1 = '123 Test St';
        billTo.city = 'Test City';
        billTo.state = 'TS';
        billTo.zip = '12345';
        billTo.country = 'US';
        billTo.phone = '555-555-5555';
        billTo.email = 'test@example.com';
        order.billTo = billTo;
        
        AddressDto shipTo = new AddressDto();
        shipTo.name = 'John Doe';
        shipTo.company = 'Test Company';
        shipTo.address1 = '123 Test St';
        shipTo.city = 'Test City';
        shipTo.state = 'TS';
        shipTo.zip = '12345';
        shipTo.country = 'US';
        shipTo.phone = '555-555-5555';
        shipTo.email = 'test@example.com';
        order.shipTo = shipTo;
        
        OrderItemDto item = new OrderItemDto();
        item.sku = 'TEST-SKU-001';
        item.name = 'Test Item';
        item.quantity = 1;
        item.price = 100.00;
        item.weight = 1.0;
        item.weightUnit = 'lb';
        item.metadata = new Map<String, Object>();
        order.items = new List<OrderItemDto>{item};
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateOrder(order);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListOrders() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.listOrders(
            TEST_BRAND_ID,
            TEST_WAREHOUSE_ID,
            TEST_STATUS,
            1,
            10,
            'createdAt',
            'desc'
        );
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetOrder() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getOrder(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCancelOrder() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.cancelOrder(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testMarkOrderShipped() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.markOrderShipped(
            TEST_ORDER_ID,
            TEST_TRACKING_NUMBER,
            TEST_CARRIER
        );
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testUpdateOrderStatus() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateOrderStatus(
            TEST_ORDER_ID,
            'shipped'
        );
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testSplitOrder() {
        Test.startTest();
        
        SplitOrderDto split = new SplitOrderDto();
        split.orderId = TEST_ORDER_ID;
        split.items = new List<SplitItemDto>();
        
        SplitItemDto item = new SplitItemDto();
        item.orderItemId = 'TEST-ITEM-001';
        item.quantity = 1;
        split.items.add(item);
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.splitOrder(TEST_ORDER_ID, split);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCreateWebhook() {
        Test.startTest();
        
        WebhookDto webhook = new WebhookDto();
        webhook.name = TEST_WEBHOOK_NAME;
        webhook.storefrontId = TEST_STOREFRONT_ID;
        webhook.onEvent = TEST_WEBHOOK_EVENT;
        webhook.toURL = TEST_WEBHOOK_URL;
        webhook.enabled = true;
        webhook.createdAt = System.now();
        webhook.updatedAt = System.now();
        webhook.metadata = new Map<String, Object>();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWebhook(webhook);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testUpdateWebhook() {
        Test.startTest();
        
        WebhookDto webhook = new WebhookDto();
        webhook.id = TEST_WEBHOOK_ID;
        webhook.name = TEST_WEBHOOK_NAME;
        webhook.storefrontId = TEST_STOREFRONT_ID;
        webhook.onEvent = TEST_WEBHOOK_EVENT;
        webhook.toURL = TEST_WEBHOOK_URL;
        webhook.enabled = true;
        webhook.createdAt = System.now();
        webhook.updatedAt = System.now();
        webhook.metadata = new Map<String, Object>();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateWebhook(webhook);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListWebhooks() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWebhooks(TEST_BRAND_ID, 1, 10);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetWebhook() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWebhook(TEST_WEBHOOK_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testDeleteWebhook() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.deleteWebhook(TEST_WEBHOOK_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCreateBulkShipment() {
        Test.startTest();
        
        BulkShipmentDto shipment = new BulkShipmentDto();
        shipment.brandId = TEST_BRAND_ID;
        shipment.fromWarehouseId = TEST_WAREHOUSE_ID;
        shipment.items = new List<BulkShipmentItemDto>();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createBulkShipment(shipment);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListBulkShipments() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.listBulkShipments(
            TEST_BRAND_ID,
            TEST_WAREHOUSE_ID,
            TEST_STATUS,
            1,
            10
        );
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetBulkShipment() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getBulkShipment(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetBrand() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getBrand(TEST_BRAND_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListBrands() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.listBrands(1, 10, 'name', 'asc');
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testErrorResponse() {
        Test.startTest();
        
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid request","details":["Invalid parameters"]}'));
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getOrder(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(400, response.statusCode, 'Expected status code 400');
        System.assertEquals(false, response.isSuccess, 'Expected error response');
        System.assertEquals('Invalid request', response.errorMessage, 'Expected error message');
    }
    
    @IsTest
    static void testHandleResponseNull() {
        Test.startTest();
        // Use a public method that will result in a null response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment(null);
        Test.stopTest();
        
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('No response received from server', response.errorMessage, 'Error message should match');
        System.assertEquals('NO_RESPONSE', response.errorCode, 'Error code should match');
    }
    
    @IsTest
    static void testHandleResponseEmptyBody() {
        Test.startTest();
        // Use a public method that will result in an empty response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('empty-response-id');
        Test.stopTest();
        
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('Empty response body received', response.errorMessage, 'Error message should match');
        System.assertEquals('EMPTY_RESPONSE', response.errorCode, 'Error code should match');
    }
    
    @IsTest
    static void testHandleResponseParseError() {
        Test.startTest();
        // Use a public method that will result in an invalid JSON response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('invalid-json-id');
        Test.stopTest();
        
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('Failed to parse error response', response.errorMessage, 'Error message should match');
        System.assertEquals('PARSE_ERROR', response.errorCode, 'Error code should match');
        System.assertNotEquals(null, response.errorDetails, 'Error details should not be null');
        System.assertNotEquals(null, response.errorData, 'Error data should not be null');
    }
    
    @IsTest
    static void testHandleResponseSpecificStatusCodes() {
        Map<Integer, String> statusCodes = new Map<Integer, String>{
            400 => 'BAD_REQUEST',
            401 => 'UNAUTHORIZED',
            403 => 'FORBIDDEN',
            404 => 'NOT_FOUND',
            429 => 'RATE_LIMIT',
            500 => 'SERVER_ERROR',
            503 => 'SERVICE_UNAVAILABLE'
        };
        
        for (Integer statusCode : statusCodes.keySet()) {
            Test.startTest();
            // Use a public method that will result in the specific status code
            LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('status-' + statusCode);
            Test.stopTest();
            
            System.assertEquals(false, response.isSuccess, 'Response should not be successful');
            System.assertEquals(statusCodes.get(statusCode), response.errorCode, 'Error code should match for status ' + statusCode);
        }
    }
    
    @IsTest
    static void testHandleResponseSuccess() {
        Test.startTest();
        // Use a public method that will result in a successful response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('success-id');
        Test.stopTest();
        
        System.assertEquals(true, response.isSuccess, 'Response should be successful');
        System.assertEquals(200, response.statusCode, 'Status code should be 200');
        System.assertNotEquals(null, response.body, 'Response body should not be null');
    }
    
    @IsTest
    static void testHandleResponseErrorWithDetails() {
        Test.startTest();
        // Use a public method that will result in a detailed error response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('detailed-error-id');
        Test.stopTest();
        
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('Test error', response.errorMessage, 'Error message should match');
        System.assertEquals('TEST_ERROR', response.errorCode, 'Error code should match');
        System.assertEquals('Test details', response.errorDetails, 'Error details should match');
        System.assertNotEquals(null, response.errorData, 'Error data should not be null');
        System.assertEquals('value', response.errorData.get('key'), 'Error data should contain correct value');
    }
    
    @IsTest
    static void testHandleResponseNullErrorResponse() {
        Test.startTest();
        // Use a public method that will result in a null error response
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('null-error-id');
        Test.stopTest();
        
        System.assertEquals(false, response.isSuccess, 'Response should not be successful');
        System.assertEquals('Failed to parse error response', response.errorMessage, 'Error message should match');
        System.assertEquals('PARSE_ERROR', response.errorCode, 'Error code should match');
        System.assertEquals('null', response.errorDetails, 'Error details should match');
    }
    
    @IsTest
    static void testCalculateRates() {
        // Prepare test request
        RateRequestDto request = new RateRequestDto();
        request.brandId = 'test-brand-id';
        request.warehouseId = 'test-warehouse-id';
        request.destination = new AddressDto();
        request.destination.country = 'US';
        request.destination.state = 'CA';
        request.destination.city = 'San Francisco';
        request.destination.zip = '94105';
        request.destination.address1 = '123 Test St';
        
        RateItemDto item = new RateItemDto();
        item.sku = 'TEST-SKU';
        item.quantity = 1;
        item.weight = 1.0;
        item.length = 10.0;
        item.width = 10.0;
        item.height = 10.0;
        request.items = new List<RateItemDto>{ item };
        
        // Execute test
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.calculateRates(request);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetShipment() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getShipment('test-shipment-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListShipments() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.listShipments(
            'test-brand-id',
            'test-warehouse-id',
            'active',
            1,
            10,
            'createdAt',
            'desc'
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    // Warehouse Shipment Tests
    @IsTest
    static void testListWarehouseShipments() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWarehouseShipments(
            1,
            10,
            'createdAt',
            'desc'
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testGetWarehouseShipment() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseShipment('test-shipment-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCreateWarehouseTransfer() {
        Test.startTest();
        
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.fromWarehouseId = TEST_WAREHOUSE_ID;
        shipment.toWarehouseId = 'test-destination-warehouse-id';
        shipment.referenceNumber = 'TEST-TRANSFER-001';
        shipment.expectedDateTimeUtc = System.now();
        shipment.items = new List<WarehouseShipmentItemCreateReq>();
        
        WarehouseShipmentItemCreateReq item = new WarehouseShipmentItemCreateReq();
        item.warehouseProductId = 'test-product-id';
        item.quantity = 10;
        item.lotNumber = 'LOT-001';
        shipment.items.add(item);
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouseTransfer(shipment);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCreateASN() {
        Test.startTest();
        
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.fromWarehouseId = TEST_WAREHOUSE_ID;
        shipment.toWarehouseId = 'test-destination-warehouse-id';
        shipment.referenceNumber = 'TEST-ASN-001';
        shipment.expectedDateTimeUtc = System.now();
        shipment.items = new List<WarehouseShipmentItemCreateReq>();
        
        WarehouseShipmentItemCreateReq item = new WarehouseShipmentItemCreateReq();
        item.warehouseProductId = 'test-product-id';
        item.quantity = 10;
        item.lotNumber = 'LOT-001';
        shipment.items.add(item);
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createASN(shipment);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testConfirmShipmentReceived() {
        Test.startTest();
        
        WarehouseShipmentConfirmReceivedReq confirmation = new WarehouseShipmentConfirmReceivedReq();
        confirmation.receivedAtDateTimeUtc = System.now();
        confirmation.items = new List<WarehouseShipmentItemConfirmReceivedReq>();
        
        WarehouseShipmentItemConfirmReceivedReq item = new WarehouseShipmentItemConfirmReceivedReq();
        item.warehouseShipmentItemId = 'test-shipment-item-id';
        item.quantityReceived = 10;
        item.lotNumber = 'LOT-001';
        confirmation.items.add(item);
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.confirmShipmentReceived('test-shipment-id', confirmation);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testMarkShipmentInTransit() {
        Test.startTest();
        
        WarehouseShipmentMarkInTransitReq transitRequest = new WarehouseShipmentMarkInTransitReq();
        transitRequest.inTransitDateTimeUtc = System.now();
        transitRequest.carrier = 'Test Carrier';
        transitRequest.trackingNumber = 'TEST-TRACK-001';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.markShipmentInTransit('test-shipment-id', transitRequest);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testCancelShipment() {
        Test.startTest();
        
        WarehouseShipmentCancelReq cancelRequest = new WarehouseShipmentCancelReq();
        cancelRequest.cancelReason = 'Test cancellation reason';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.cancelShipment('test-shipment-id', cancelRequest);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testListWarehouseShipmentsWithNullParams() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWarehouseShipments(
            null,
            null,
            null,
            null
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    static void testWarehouseShipmentErrorResponse() {
        Test.startTest();
        
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouseTransfer(shipment);
        
        Test.stopTest();
        
        System.assertEquals(400, response.statusCode, 'Expected status code 400');
        System.assertEquals(false, response.isSuccess, 'Expected error response');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Expected error message');
    }
} 