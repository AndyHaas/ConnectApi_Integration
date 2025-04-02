/**
 * @description Main service class for interacting with the LacoreConnect API.
 * This class extends RestClientLib to provide REST API functionality and implements
 * a singleton pattern for efficient resource usage.
 */
public class LacoreConnectService extends RestClientLib {
    private static final String NAMED_CREDENTIAL = 'LacoreConnect';
    private static LacoreConnectService instance;
    
    /**
     * @description Private constructor to enforce singleton pattern
     */
    private LacoreConnectService() {
        super(NAMED_CREDENTIAL);
    }
    
    /**
     * @description Gets the singleton instance of LacoreConnectService
     * @return LacoreConnectService The singleton instance
     */
    public static LacoreConnectService getInstance() {
        if (instance == null) {
            instance = new LacoreConnectService();
        }
        return instance;
    }
    
    /**
     * @description Inner class to represent API responses
     */
    @TestVisible
    public class ApiResponse {
        /** HTTP status code of the response */
        public Integer statusCode;
        /** Raw response body */
        public String body;
        /** Whether the request was successful */
        public Boolean isSuccess;
        /** Error message if the request failed */
        public String errorMessage;
        /** Error code if the request failed */
        public String errorCode;
        /** Detailed error information */
        public String errorDetails;
        /** Additional error data as a map */
        public Map<String, Object> errorData;
    }
    
    /**
     * @description Gets the default headers for API requests
     * @return Map<String, String> Map of default headers
     */
    private static Map<String, String> getDefaultHeaders() {
        return new Map<String, String>{
            'Content-Type' => 'application/json'
        };
    }
    
    /**
     * @description Handles the HTTP response and converts it to an ApiResponse object
     * @param httpResponse The raw HTTP response from the API
     * @return ApiResponse Processed API response
     */
    private static ApiResponse handleResponse(HttpResponse httpResponse) {
        ApiResponse response = new ApiResponse();
        
        if (httpResponse == null) {
            response.isSuccess = false;
            response.errorMessage = 'No response received from server';
            response.errorCode = 'NO_RESPONSE';
            return response;
        }
        
        response.statusCode = httpResponse.getStatusCode();
        response.body = httpResponse.getBody();
        
        // Check for empty response body
        if (String.isBlank(response.body)) {
            response.isSuccess = false;
            response.errorMessage = 'Empty response body received';
            response.errorCode = 'EMPTY_RESPONSE';
            return response;
        }
        
        // Determine success based on status code
        response.isSuccess = response.statusCode >= 200 && response.statusCode < 300;
        
        if (!response.isSuccess) {
            try {
                // Handle null response body
                if (response.body == 'null') {
                    response.errorMessage = 'Failed to parse error response';
                    response.errorCode = 'PARSE_ERROR';
                    response.errorDetails = 'null';
                    response.errorData = new Map<String, Object>{ 'rawResponse' => 'null' };
                } else {
                    Map<String, Object> errorMap = (Map<String, Object>)JSON.deserializeUntyped(response.body);
                    
                    // Extract error details with null checks
                    response.errorMessage = (String)errorMap.get('message');
                    response.errorCode = (String)errorMap.get('error');
                    response.errorDetails = (String)errorMap.get('details');
                    response.errorData = (Map<String, Object>)errorMap.get('data');
                    
                    // If no specific error code, use status code based code
                    if (String.isBlank(response.errorCode)) {
                        switch on response.statusCode {
                            when 400 { response.errorCode = 'BAD_REQUEST'; }
                            when 401 { response.errorCode = 'UNAUTHORIZED'; }
                            when 403 { response.errorCode = 'FORBIDDEN'; }
                            when 404 { response.errorCode = 'NOT_FOUND'; }
                            when 429 { response.errorCode = 'RATE_LIMIT'; }
                            when 500 { response.errorCode = 'SERVER_ERROR'; }
                            when 503 { response.errorCode = 'SERVICE_UNAVAILABLE'; }
                            when else { response.errorCode = 'UNKNOWN_ERROR'; }
                        }
                    }
                }
            } catch (Exception e) {
                response.isSuccess = false;
                response.errorMessage = 'Failed to parse error response: ' + e.getMessage();
                response.errorCode = 'PARSE_ERROR';
                response.errorDetails = e.getMessage();
                response.errorData = new Map<String, Object>{ 'exception' => e.getMessage() };
            }
        }
        
        return response;
    }
    
    // Rate Operations
    public static ApiResponse calculateRates(RateRequestDto request) {
        return handleResponse(getInstance().post('/rates/orders/estimate', DTOs.serialize(request)));
    }
    
    // Shipment Operations
    public static ApiResponse getShipment(String id) {
        return handleResponse(getInstance().get('/shipments/' + id));
    }
    
    public static ApiResponse listShipments(String brandId, String warehouseId, String status, Integer page, Integer pageSize, String sortBy, String sortDir) {
        String endpoint = '/shipments';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'brandId' => brandId,
            'warehouseId' => warehouseId,
            'status' => status,
            'page' => String.valueOf(page),
            'pageSize' => String.valueOf(pageSize),
            'sortBy' => sortBy,
            'sortDir' => sortDir
        });
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    // Order Operations
    public static ApiResponse createOrder(OrderDto order) {
        return createOrders(new List<OrderDto>{order});
    }
    
    public static ApiResponse createOrders(List<OrderDto> orders) {
        return handleResponse(getInstance().post('/orders', DTOs.serialize(orders)));
    }
    
    public static ApiResponse updateOrder(OrderDto order) {
        return updateOrders(new List<OrderDto>{order});
    }
    
    public static ApiResponse updateOrders(List<OrderDto> orders) {
        return handleResponse(getInstance().put('/orders', DTOs.serialize(orders)));
    }
    
    public static ApiResponse getOrder(String id) {
        return handleResponse(getInstance().get('/orders/' + id));
    }
    
    public static ApiResponse getOrders(List<String> orderIds) {
        String endpoint = '/orders';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'orderIds' => String.join(orderIds, ',')
        });
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse deleteOrder(String id) {
        return handleResponse(getInstance().del('/orders/' + id));
    }
    
    public static ApiResponse deleteOrders(List<String> orderIds) {
        String endpoint = '/orders';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'orderIds' => String.join(orderIds, ',')
        });
        return handleResponse(getInstance().del(endpoint + queryString));
    }
    
    public static ApiResponse listOrders(String storefrontId, Integer page, Integer pageSize, String sortBy, String sortDir, Date createdDateStart, Date createdDateEnd, Date orderDateStart, Date orderDateEnd, String orderNumber, String orderStatus) {
        String endpoint = '/orders';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'storefrontId' => storefrontId,
            'page' => String.valueOf(page),
            'pageSize' => String.valueOf(pageSize),
            'sortBy' => sortBy,
            'sortDir' => sortDir,
            'createdDateStart' => String.valueOf(createdDateStart),
            'createdDateEnd' => String.valueOf(createdDateEnd),
            'orderDateStart' => String.valueOf(orderDateStart),
            'orderDateEnd' => String.valueOf(orderDateEnd),
            'orderNumber' => orderNumber,
            'orderStatus' => orderStatus
        });
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse cancelOrder(String id) {
        Map<String, Object> requestBody = new Map<String, Object>{
            'orderStatus' => 'cancelled'
        };
        return handleResponse(getInstance().post('/orders/' + id + '/orderStatus', DTOs.serialize(requestBody)));
    }
    
    public static ApiResponse markOrderShipped(String id, String trackingNumber, String carrier) {
        Map<String, Object> requestBody = new Map<String, Object>{
            'trackingNumber' => trackingNumber,
            'carrier' => carrier
        };
        return handleResponse(getInstance().post('/orders/' + id + '/markShipped', DTOs.serialize(requestBody)));
    }
    
    public static ApiResponse updateOrderStatus(String id, String status) {
        Map<String, Object> requestBody = new Map<String, Object>{
            'orderStatus' => status
        };
        return handleResponse(getInstance().post('/orders/' + id + '/orderStatus', DTOs.serialize(requestBody)));
    }
    
    public static ApiResponse splitOrder(String id, SplitOrderDto split) {
        return handleResponse(getInstance().post('/orders/' + id + '/split', DTOs.serialize(split)));
    }
    
    // Webhook Operations
    public static ApiResponse createWebhook(WebhookDto webhook) {
        return handleResponse(getInstance().post('/webhooks', DTOs.serialize(webhook)));
    }
    
    public static ApiResponse updateWebhook(WebhookDto webhook) {
        return handleResponse(getInstance().put('/webhooks/' + webhook.id, DTOs.serialize(webhook)));
    }
    
    public static ApiResponse listWebhooks(String brandId, Integer page, Integer pageSize) {
        String endpoint = '/webhooks';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'brandId' => brandId,
            'page' => String.valueOf(page),
            'pageSize' => String.valueOf(pageSize)
        });
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getWebhook(String id) {
        return handleResponse(getInstance().get('/webhooks/' + id));
    }
    
    public static ApiResponse deleteWebhook(String id) {
        return handleResponse(getInstance().del('/webhooks/' + id));
    }
    
    // Bulk Shipment Operations
    public static ApiResponse createBulkShipment(BulkShipmentDto shipment) {
        return handleResponse(getInstance().post('/bulk-shipments', DTOs.serialize(shipment)));
    }
    
    public static ApiResponse listBulkShipments(String brandId, String warehouseId, String status, Integer page, Integer pageSize) {
        String endpoint = '/bulk-shipments';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'brandId' => brandId,
            'warehouseId' => warehouseId,
            'status' => status,
            'page' => String.valueOf(page),
            'pageSize' => String.valueOf(pageSize)
        });
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getBulkShipment(String id) {
        return handleResponse(getInstance().get('/bulk-shipments/' + id));
    }
    
    // Brand Operations
    public static ApiResponse getBrand() {
        return handleResponse(getInstance().get('/brands'));
    }
    
    public static ApiResponse getProductStatistics(StatisticsRequestDto request) {
        String endpoint = '/reports/productStatistics';
        String method = 'GET';
        String body = JSON.serialize(request);
        
        return handleResponse(getInstance().post(endpoint, body));
    }
    
    // Storefront Product Operations
    public static ApiResponse getStorefrontProducts(String storefrontId, String sku, Integer page, Integer pageSize, String sortDir) {
        String endpoint = '/storefrontProducts';
        Map<String, String> queryParams = new Map<String, String>();
        
        // Add optional parameters if they are not null
        if (String.isNotBlank(storefrontId)) {
            queryParams.put('storefrontId', storefrontId);
        }
        if (String.isNotBlank(sku)) {
            queryParams.put('sku', sku);
        }
        if (page != null) {
            queryParams.put('page', String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.put('pageSize', String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.put('sortDir', sortDir);
        }
        
        String queryString = HttpUtils.buildQueryString(queryParams);
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getStorefrontProductById(String id) {
        return handleResponse(getInstance().get('/storefrontProducts/' + id));
    }
    
    public static ApiResponse createStorefrontProduct(StorefrontProductDto product) {
        return handleResponse(getInstance().post('/storefrontProducts', DTOs.serialize(product)));
    }
    
    public static ApiResponse updateStorefrontProduct(String id, StorefrontProductDto product) {
        return handleResponse(getInstance().put('/storefrontProducts/' + id, DTOs.serialize(product)));
    }
    
    public static ApiResponse deleteStorefrontProduct(String id) {
        return handleResponse(getInstance().del('/storefrontProducts/' + id));
    }
    
    // Storefront Operations
    public static ApiResponse getStorefronts(Integer page, Integer pageSize, String sortDir) {
        String endpoint = '/storefronts';
        Map<String, String> queryParams = new Map<String, String>();
        
        // Add optional parameters if they are not null
        if (page != null) {
            queryParams.put('page', String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.put('pageSize', String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.put('sortDir', sortDir);
        }
        
        String queryString = HttpUtils.buildQueryString(queryParams);
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getStorefrontById(String id) {
        return handleResponse(getInstance().get('/storefronts/' + id));
    }
    
    public static ApiResponse getVendors() {
        String endpoint = '/vendors';
        
        return handleResponse(getInstance().get(endpoint));
    }
    
    // Warehouse Product Operations
    public static ApiResponse getWarehouseProducts(String warehouseId, String sku, Integer page, Integer pageSize, String sortDir) {
        String endpoint = '/warehouseProducts';
        Map<String, String> queryParams = new Map<String, String>();
        
        // Add optional parameters if they are not null
        if (String.isNotBlank(warehouseId)) {
            queryParams.put('warehouseId', warehouseId);
        }
        if (String.isNotBlank(sku)) {
            queryParams.put('sku', sku);
        }
        if (page != null) {
            queryParams.put('page', String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.put('pageSize', String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.put('sortDir', sortDir);
        }
        
        String queryString = HttpUtils.buildQueryString(queryParams);
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getWarehouseProductById(String id) {
        return handleResponse(getInstance().get('/warehouseProducts/' + id));
    }
    
    public static ApiResponse createWarehouseProduct(WarehouseProductDto product) {
        return handleResponse(getInstance().post('/warehouseProducts', DTOs.serialize(product)));
    }
    
    public static ApiResponse updateWarehouseProduct(String id, WarehouseProductDto product) {
        return handleResponse(getInstance().put('/warehouseProducts/' + id, DTOs.serialize(product)));
    }
    
    public static ApiResponse deleteWarehouseProduct(String id) {
        return handleResponse(getInstance().del('/warehouseProducts/' + id));
    }
    
    public static ApiResponse getWarehouseProductInventoryByLocation(
        String item,
        String warehouseProductId,
        String warehouseId,
        String brandId,
        String lpn,
        String locationCode,
        String lotNumber,
        Integer page,
        Integer pageSize,
        String sortDir
    ) {
        String endpoint = '/warehouseProducts/inventory/byLocation';
        
        // Build query parameters
        List<String> queryParams = new List<String>();
        
        if (String.isNotBlank(item)) {
            queryParams.add('item=' + EncodingUtil.urlEncode(item, 'UTF-8'));
        }
        if (String.isNotBlank(warehouseProductId)) {
            queryParams.add('warehouseProductId=' + EncodingUtil.urlEncode(warehouseProductId, 'UTF-8'));
        }
        if (String.isNotBlank(warehouseId)) {
            queryParams.add('warehouseId=' + EncodingUtil.urlEncode(warehouseId, 'UTF-8'));
        }
        if (String.isNotBlank(brandId)) {
            queryParams.add('brandId=' + EncodingUtil.urlEncode(brandId, 'UTF-8'));
        }
        if (String.isNotBlank(lpn)) {
            queryParams.add('lpn=' + EncodingUtil.urlEncode(lpn, 'UTF-8'));
        }
        if (String.isNotBlank(locationCode)) {
            queryParams.add('locationCode=' + EncodingUtil.urlEncode(locationCode, 'UTF-8'));
        }
        if (String.isNotBlank(lotNumber)) {
            queryParams.add('lotNumber=' + EncodingUtil.urlEncode(lotNumber, 'UTF-8'));
        }
        if (page != null) {
            queryParams.add('page=' + String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.add('pageSize=' + String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.add('sortDir=' + EncodingUtil.urlEncode(sortDir, 'UTF-8'));
        }
        
        // Add query parameters to endpoint if any exist
        if (!queryParams.isEmpty()) {
            endpoint += '?' + String.join(queryParams, '&');
        }
        
        return handleResponse(getInstance().get(endpoint));
    }
    
    public static ApiResponse updateWarehouseProductInventory(WarehouseProductInventoryDto inventory) {
        return handleResponse(getInstance().put('/warehouseProducts/inventorySummary', DTOs.serialize(inventory)));
    }
    
    // Warehouse Operations
    public static ApiResponse listWarehouses(Integer page, Integer pageSize, String sortBy, String sortDir) {
        String endpoint = '/warehouses';
        Map<String, String> queryParams = new Map<String, String>();
        
        if (page != null) {
            queryParams.put('page', String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.put('pageSize', String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortBy)) {
            queryParams.put('sortBy', sortBy);
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.put('sortDir', sortDir);
        }
        
        String queryString = HttpUtils.buildQueryString(queryParams);
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getWarehouseById(String id) {
        return handleResponse(getInstance().get('/warehouses/' + id));
    }
    
    public static ApiResponse createWarehouse(WarehouseDto warehouse) {
        return handleResponse(getInstance().post('/warehouses', DTOs.serialize(warehouse)));
    }
    
    public static ApiResponse updateWarehouse(WarehouseDto warehouse) {
        return handleResponse(getInstance().put('/warehouses', DTOs.serialize(warehouse)));
    }
    
    public static ApiResponse deleteWarehouse(String id) {
        return handleResponse(getInstance().del('/warehouses/' + id));
    }
    
    // Warehouse Shipment Operations
    public static ApiResponse listWarehouseShipments(Integer page, Integer pageSize, String sortBy, String sortDir) {
        String endpoint = '/v2/inventory/shipments';
        Map<String, String> queryParams = new Map<String, String>();
        
        if (page != null) {
            queryParams.put('page', String.valueOf(page));
        }
        if (pageSize != null) {
            queryParams.put('pageSize', String.valueOf(pageSize));
        }
        if (String.isNotBlank(sortBy)) {
            queryParams.put('sortBy', sortBy);
        }
        if (String.isNotBlank(sortDir)) {
            queryParams.put('sortDir', sortDir);
        }
        
        String queryString = HttpUtils.buildQueryString(queryParams);
        return handleResponse(getInstance().get(endpoint + queryString));
    }
    
    public static ApiResponse getWarehouseShipment(String id) {
        return handleResponse(getInstance().get('/v2/inventory/shipments/' + id));
    }
    
    public static ApiResponse createWarehouseTransfer(WarehouseShipmentCreateReq shipment) {
        return handleResponse(getInstance().post('/v2/inventory/shipments/warehouseTransfer', DTOs.serialize(shipment)));
    }
    
    public static ApiResponse createASN(WarehouseShipmentCreateReq shipment) {
        return handleResponse(getInstance().post('/v2/inventory/shipments/asn', DTOs.serialize(shipment)));
    }
    
    public static ApiResponse confirmShipmentReceived(String id, WarehouseShipmentConfirmReceivedReq confirmation) {
        return handleResponse(getInstance().put('/v2/inventory/shipments/' + id + '/confirmReceived', DTOs.serialize(confirmation)));
    }
    
    public static ApiResponse markShipmentInTransit(String id) {
        return handleResponse(getInstance().put('/v2/inventory/shipments/' + id + '/markInTransit',''));
    }
    
    public static ApiResponse cancelShipment(String id) {
        return handleResponse(getInstance().put('/v2/inventory/shipments/' + id + '/cancel', ''));
    }

    public static ApiResponse getWarehouseShipmentById(String id) {
        return handleResponse(getInstance().get('/v2/inventory/shipments/' + id));
    }
} 