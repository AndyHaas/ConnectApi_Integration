/**
 * @description Test class for LacoreConnectService.
 * This class provides comprehensive test coverage for all service methods,
 * including order management, webhook handling, warehouse operations,
 * and shipment processing.
 */
@IsTest
public without sharing class LacoreConnectServiceTest {
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
    public static void setup() {
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock());
    }
    
    @IsTest
    public static void testCreateOrder() {
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
    public static void testUpdateOrder() {
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
    public static void testListOrders() {
        Test.startTest();

        LacoreConnectService.ApiResponse response = LacoreConnectService.listOrders(
            TEST_STOREFRONT_ID,
            1,
            10,
            'createdAt',
            'desc',
            Date.today(),
            Date.today(),
            Date.today(),
            Date.today(),
            '1234567890',
            'DRAFT'
        );
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetOrder() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getOrder(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCancelOrder() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.cancelOrder(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testMarkOrderShipped() {
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
    public static void testUpdateOrderStatus() {
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
    public static void testSplitOrder() {
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
    public static void testCreateWebhook() {
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
    public static void testUpdateWebhook() {
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
    public static void testListWebhooks() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWebhooks(TEST_BRAND_ID, 1, 10);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWebhook() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWebhook(TEST_WEBHOOK_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testDeleteWebhook() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.deleteWebhook(TEST_WEBHOOK_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateBulkShipment() {
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
    public static void testListBulkShipments() {
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
    public static void testGetBulkShipment() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getBulkShipment(TEST_ORDER_ID);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetBrand() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getBrand();
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetProductStatistics() {
        Test.startTest();
        
        StatisticsRequestDto request = new StatisticsRequestDto();
        request.brandId = TEST_BRAND_ID;
        request.warehouseId = TEST_WAREHOUSE_ID;
        request.startDate = System.now().addDays(-30);
        request.endDate = System.now();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.getProductStatistics(request);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetStorefrontProducts() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefrontProducts(
            TEST_STOREFRONT_ID,
            'TEST-SKU',
            1,
            10,
            'desc'
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetStorefrontProductById() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefrontProductById('test-product-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateStorefrontProduct() {
        Test.startTest();
        
        StorefrontProductDto product = new StorefrontProductDto();
        product.name = 'Test Product';
        product.sku = 'TEST-SKU';
        product.description = 'Test Description';
        product.price = 100.00;
        product.brandId = TEST_BRAND_ID;
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createStorefrontProduct(product);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testUpdateStorefrontProduct() {
        Test.startTest();
        
        StorefrontProductDto product = new StorefrontProductDto();
        product.id = 'test-product-id';
        product.name = 'Updated Test Product';
        product.sku = 'TEST-SKU';
        product.description = 'Updated Test Description';
        product.price = 150.00;
        product.brandId = TEST_BRAND_ID;
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateStorefrontProduct('test-product-id', product);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testDeleteStorefrontProduct() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.deleteStorefrontProduct('test-product-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetStorefronts() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefronts(1, 10, 'desc');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetStorefrontById() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getStorefrontById('test-storefront-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetVendors() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getVendors();
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWarehouseProducts() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseProducts(
            TEST_WAREHOUSE_ID,
            'TEST-SKU',
            1,
            10,
            'desc'
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWarehouseProductById() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseProductById('test-product-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateWarehouseProduct() {
        Test.startTest();
        
        WarehouseProductDto product = new WarehouseProductDto();
        product.name = 'Test Product';
        product.sku = 'TEST-SKU';
        product.description = 'Test Description';
        product.warehouseId = TEST_WAREHOUSE_ID;
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouseProduct(product);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testUpdateWarehouseProduct() {
        Test.startTest();
        
        WarehouseProductDto product = new WarehouseProductDto();
        product.id = 'test-product-id';
        product.name = 'Updated Test Product';
        product.sku = 'TEST-SKU';
        product.description = 'Updated Test Description';
        product.warehouseId = TEST_WAREHOUSE_ID;
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateWarehouseProduct('test-product-id', product);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testDeleteWarehouseProduct() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.deleteWarehouseProduct('test-product-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWarehouseProductInventoryByLocation() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseProductInventoryByLocation(
            'test-item',
            'test-product-id',
            TEST_WAREHOUSE_ID,
            TEST_BRAND_ID,
            'test-lpn',
            'test-location',
            'test-lot',
            1,
            10,
            'desc'
        );
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testUpdateWarehouseProductInventory() {
        Test.startTest();
        
        WarehouseProductInventoryDto inventory = new WarehouseProductInventoryDto();
        inventory.warehouseProductId = 'test-product-id';
        inventory.quantity = 100;
        inventory.locationCode = 'TEST-LOC';
        inventory.lotNumber = 'TEST-LOT';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateWarehouseProductInventory(inventory);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testListWarehouses() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWarehouses(1, 10, 'name', 'desc');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWarehouseById() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseById('test-warehouse-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateWarehouse() {
        Test.startTest();
        
        WarehouseDto warehouse = new WarehouseDto();
        warehouse.name = 'Test Warehouse';
        warehouse.code = 'TEST-WH';
        warehouse.addressBusinessName = 'Test Company';
        warehouse.addressLine1 = '123 Test St';
        warehouse.addressCity = 'Test City';
        warehouse.addressState = 'TS';
        warehouse.addressZipCode = '12345';
        warehouse.addressCountryCode = 'US';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouse(warehouse);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testUpdateWarehouse() {
        Test.startTest();
        
        WarehouseDto warehouse = new WarehouseDto();
        warehouse.id = 'test-warehouse-id';
        warehouse.name = 'Updated Test Warehouse';
        warehouse.code = 'TEST-WH';
        warehouse.addressBusinessName = 'Test Company';
        warehouse.addressLine1 = '123 Test St';
        warehouse.addressCity = 'Test City';
        warehouse.addressState = 'TS';
        warehouse.addressZipCode = '12345';
        warehouse.addressCountryCode = 'US';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.updateWarehouse(warehouse);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testDeleteWarehouse() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.deleteWarehouse('test-warehouse-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testListWarehouseShipments() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.listWarehouseShipments(1, 10, 'createdAt', 'desc');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testGetWarehouseShipment() {
        Test.startTest();
        LacoreConnectService.ApiResponse response = LacoreConnectService.getWarehouseShipment('test-shipment-id');
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateWarehouseTransfer() {
        Test.startTest();
        
        WarehouseShipmentCreateReq request = new WarehouseShipmentCreateReq();
        request.fromWarehouseId = TEST_WAREHOUSE_ID;
        request.toWarehouseId = 'test-warehouse-id-2';
        request.referenceNumber = 'TEST-TRANSFER-001';
        
        WarehouseShipmentItemCreateReq item = new WarehouseShipmentItemCreateReq();
        item.warehouseProductId = 'test-product-id';
        item.quantity = 1;
        item.lotNumber = 'TEST-LOT-001';
        request.items = new List<WarehouseShipmentItemCreateReq>{item};
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouseTransfer(request);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCreateASN() {
        Test.startTest();
        
        WarehouseShipmentCreateReq request = new WarehouseShipmentCreateReq();
        request.fromWarehouseId = 'test-warehouse-id-2';
        request.toWarehouseId = TEST_WAREHOUSE_ID;
        request.referenceNumber = 'TEST-ASN-001';
        
        WarehouseShipmentItemCreateReq item = new WarehouseShipmentItemCreateReq();
        item.warehouseProductId = 'test-product-id';
        item.quantity = 1;
        item.lotNumber = 'TEST-LOT-001';
        request.items = new List<WarehouseShipmentItemCreateReq>{item};
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.createASN(request);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testConfirmShipmentReceived() {
        Test.startTest();
        
        WarehouseShipmentConfirmReceivedReq request = new WarehouseShipmentConfirmReceivedReq();
        request.note = 'Test confirmation';
        
        WarehouseShipmentItemConfirmReceivedReq item = new WarehouseShipmentItemConfirmReceivedReq();
        item.warehouseShipmentItemId = 'test-shipment-item-id';
        item.quantityReceived = 1;
        item.lotNumber = 'TEST-LOT-001';
        request.items = new List<WarehouseShipmentItemConfirmReceivedReq>{item};
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.confirmShipmentReceived('test-shipment-id', request);
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testMarkShipmentInTransit() {
        Test.startTest();
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.markShipmentInTransit('test-shipment-id');
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testCancelShipment() {
        Test.startTest();
        
        WarehouseShipmentCancelReq request = new WarehouseShipmentCancelReq();
        request.note = 'Test cancellation';
        
        LacoreConnectService.ApiResponse response = LacoreConnectService.cancelShipment('test-shipment-id');
        
        Test.stopTest();
        
        System.assertEquals(200, response.statusCode, 'Expected status code 200');
        System.assertEquals(true, response.isSuccess, 'Expected success response');
    }
    
    @IsTest
    public static void testListWarehouseShipmentsWithNullParams() {
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
    public static void testWarehouseShipmentErrorResponse() {
        Test.startTest();
        
        // Set up mock to return error response
        Test.setMock(HttpCalloutMock.class, new LacoreConnectServiceMock(400, 'Bad Request', '{"error":"invalid_request","message":"Invalid shipment data","details":["Invalid parameters"]}'));
        
        WarehouseShipmentCreateReq shipment = new WarehouseShipmentCreateReq();
        shipment.fromWarehouseId = TEST_WAREHOUSE_ID;
        shipment.toWarehouseId = 'test-warehouse-id-2';
        shipment.items = new List<WarehouseShipmentItemCreateReq>();
        
        WarehouseShipmentItemCreateReq item = new WarehouseShipmentItemCreateReq();
        item.warehouseProductId = 'test-product-id';
        item.quantity = 1;
        shipment.items.add(item);

        shipment.referenceNumber = 'TEST-TRANSFER-001';
        shipment.type = 'warehouseTransfer';
        shipment.name = 'Test Transfer';
        shipment.purchaseOrderId = 'TEST-PO-001';
        shipment.packingListId = 'TEST-PACKING-LIST-001';

        LacoreConnectService.ApiResponse response = LacoreConnectService.createWarehouseTransfer(shipment);
        
        Test.stopTest();
        
        System.assertEquals(400, response.statusCode, 'Expected status code 400');
        System.assertEquals(false, response.isSuccess, 'Expected error response');
        System.assertEquals('Invalid shipment data', response.errorMessage, 'Expected error message');
    }
} 