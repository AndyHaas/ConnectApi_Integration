/**
 * @description Test suite for all LacoreConnect test classes.
 * This suite provides a single entry point to run all tests in the package.
 */
@IsTest
public class LacoreConnectTestSuite {
    /**
     * @description Runs all test classes in the LacoreConnect package
     */
    @IsTest
    static void runAllTests() {
        // Brands Tests
        GetBrandActionTest.testExecuteWithNullResponse();
        GetBrandActionTest.testExecuteWithEmptyResponse();
        GetBrandActionTest.testExecuteWithInvalidResponse();
        
        // Orders Tests
        CreateOrderActionTest.testCreateOrder();
        CreateOrderActionTest.testCreateOrderError();
        CreateOrderActionTest.testCreateOrderBulk();
        CreateOrderActionTest.testUpdateOrder();
        CreateOrderActionTest.testCreateBulkOrders();
        CreateOrderActionTest.testUpdateBulkOrders();
        CreateOrderActionTest.testUpdateOrderError();
        
        // Get Order Tests
        GetOrderActionTest.testGetOrder();
        GetOrderActionTest.testGetOrderError();
        GetOrderActionTest.testGetOrderMultiple();
        
        // List Orders Tests
        ListOrdersActionTest.testListOrders();
        ListOrdersActionTest.testListOrdersError();
        ListOrdersActionTest.testListOrdersMultiple();
        
        // Mark Order Shipped Tests
        MarkOrderShippedActionTest.testMarkOrderShipped();
        MarkOrderShippedActionTest.testMarkOrderShippedError();
        MarkOrderShippedActionTest.testMarkOrderShippedMultiple();
        
        // Split Order Tests
        SplitOrderActionTest.testSplitOrder();
        SplitOrderActionTest.testSplitOrderError();
        SplitOrderActionTest.testSplitOrderMultiple();
        
        // Cancel Order Tests
        CancelOrderActionTest.testCancelOrder();
        CancelOrderActionTest.testCancelOrderError();
        CancelOrderActionTest.testCancelOrderMultiple();
        
        // Calculate Rates Tests
        CalculateRatesActionTest.testCalculateRates();
        CalculateRatesActionTest.testErrorHandling();
        CalculateRatesActionTest.testCalculateRatesWithMultipleItems();
        
        // Get Shipment Tests
        GetShipmentActionTest.testGetShipment();
        GetShipmentActionTest.testErrorHandling();
        
        // List Shipments Tests
        ListShipmentsActionTest.testListShipments();
        ListShipmentsActionTest.testErrorHandling();
        ListShipmentsActionTest.testListShipmentsWithOptionalFields();
        
        // Statistics Tests
        GetStatisticsActionTest.testGetStatistics();
        GetStatisticsActionTest.testGetStatisticsWithDifferentGroupBy();
        GetStatisticsActionTest.testErrorHandling();
        
        // Storefronts Tests
        GetStorefrontsActionTest.testGetStorefronts();
        GetStorefrontsActionTest.testGetStorefrontsError();
        GetStorefrontByIdActionTest.testGetStorefrontById();
        GetStorefrontByIdActionTest.testGetStorefrontByIdError();
        
        // Storefront Products Tests
        CreateStorefrontProductActionTest.testCreateStorefrontProduct();
        CreateStorefrontProductActionTest.testErrorHandling();
        DeleteStorefrontProductActionTest.testDeleteStorefrontProduct();
        DeleteStorefrontProductActionTest.testErrorHandling();
        GetStorefrontProductByIdActionTest.testGetStorefrontProductById();
        GetStorefrontProductByIdActionTest.testErrorHandling();
        GetStorefrontProductsActionTest.testGetStorefrontProducts();
        GetStorefrontProductsActionTest.testErrorHandling();
        UpdateStorefrontProductActionTest.testUpdateStorefrontProduct();
        UpdateStorefrontProductActionTest.testUpdateStorefrontProductError();
        UpdateStorefrontProductActionTest.testUpdateStorefrontProductException();
        
        // Warehouse Products Tests
        GetWarehouseProductByIdActionTest.testGetWarehouseProductById();
        GetWarehouseProductByIdActionTest.testGetWarehouseProductByIdError();
        GetWarehouseProductsActionTest.testGetWarehouseProducts();
        GetWarehouseProductsActionTest.testGetWarehouseProductsError();
        DeleteWarehouseProductActionTest.testDeleteWarehouseProduct();
        DeleteWarehouseProductActionTest.testDeleteWarehouseProductError();
        
        // Warehouse Shipments Tests
        GetWarehouseShipmentActionTest.testGetWarehouseShipmentSuccess();
        GetWarehouseShipmentActionTest.testGetWarehouseShipmentError();
        ListWarehouseShipmentsActionTest.testListWarehouseShipmentsSuccess();
        ListWarehouseShipmentsActionTest.testListWarehouseShipmentsError();
        MarkShipmentInTransitActionTest.testMarkShipmentInTransitSuccess();
        MarkShipmentInTransitActionTest.testMarkShipmentInTransitError();
        CancelShipmentActionTest.testCancelShipmentSuccess();
        CancelShipmentActionTest.testCancelShipmentError();
        
        // Utility Tests
        LacoreConnectServiceTest.testCreateOrder();
        LacoreConnectServiceTest.testUpdateOrder();
        LacoreConnectServiceTest.testListOrders();
        LacoreConnectServiceTest.testGetOrder();
        LacoreConnectServiceTest.testCancelOrder();
        LacoreConnectServiceTest.testMarkOrderShipped();
        LacoreConnectServiceTest.testUpdateOrderStatus();
        LacoreConnectServiceTest.testSplitOrder();
        LacoreConnectServiceTest.testCreateWebhook();
        LacoreConnectServiceTest.testUpdateWebhook();
        LacoreConnectServiceTest.testListWebhooks();
        LacoreConnectServiceTest.testGetWebhook();
        LacoreConnectServiceTest.testDeleteWebhook();
        LacoreConnectServiceTest.testCreateBulkShipment();
        LacoreConnectServiceTest.testListBulkShipments();
        LacoreConnectServiceTest.testGetBulkShipment();
        LacoreConnectServiceTest.testGetBrand();
        LacoreConnectServiceTest.testGetProductStatistics();
        LacoreConnectServiceTest.testGetStorefrontProducts();
        LacoreConnectServiceTest.testGetStorefrontProductById();
        LacoreConnectServiceTest.testCreateStorefrontProduct();
        LacoreConnectServiceTest.testUpdateStorefrontProduct();
        LacoreConnectServiceTest.testDeleteStorefrontProduct();
        LacoreConnectServiceTest.testGetStorefronts();
        LacoreConnectServiceTest.testGetStorefrontById();
        LacoreConnectServiceTest.testGetVendors();
        LacoreConnectServiceTest.testGetWarehouseProducts();
        LacoreConnectServiceTest.testGetWarehouseProductById();
        LacoreConnectServiceTest.testCreateWarehouseProduct();
        LacoreConnectServiceTest.testUpdateWarehouseProduct();
        LacoreConnectServiceTest.testDeleteWarehouseProduct();
        LacoreConnectServiceTest.testGetWarehouseProductInventoryByLocation();
        LacoreConnectServiceTest.testUpdateWarehouseProductInventory();
        LacoreConnectServiceTest.testListWarehouses();
        LacoreConnectServiceTest.testGetWarehouseById();
        LacoreConnectServiceTest.testCreateWarehouse();
        LacoreConnectServiceTest.testUpdateWarehouse();
        LacoreConnectServiceTest.testDeleteWarehouse();
        LacoreConnectServiceTest.testListWarehouseShipments();
        LacoreConnectServiceTest.testGetWarehouseShipment();
        LacoreConnectServiceTest.testCreateWarehouseTransfer();
        LacoreConnectServiceTest.testCreateASN();
        LacoreConnectServiceTest.testConfirmShipmentReceived();
        LacoreConnectServiceTest.testMarkShipmentInTransit();
        LacoreConnectServiceTest.testCancelShipment();
        LacoreConnectServiceTest.testListWarehouseShipmentsWithNullParams();
        LacoreConnectServiceTest.testWarehouseShipmentErrorResponse();
    }
} 