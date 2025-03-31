public class LacoreConnectService extends RestClientLib {
    private static final String NAMED_CREDENTIAL = 'LacoreConnect';
    private static LacoreConnectService instance;
    
    private LacoreConnectService() {
        super(NAMED_CREDENTIAL);
    }
    
    public static LacoreConnectService getInstance() {
        if (instance == null) {
            instance = new LacoreConnectService();
        }
        return instance;
    }
    
    public class ApiResponse {
        public Integer statusCode;
        public String body;
        public Boolean isSuccess;
        public String errorMessage;
        public String errorCode;
        public String errorDetails;
        public Map<String, Object> errorData;
    }
    
    private static Map<String, String> getDefaultHeaders() {
        return new Map<String, String>{
            'Content-Type' => 'application/json'
        };
    }
    
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
                // If we can't parse the error response, use a generic error
                response.errorMessage = 'Failed to parse error response';
                response.errorCode = 'PARSE_ERROR';
                response.errorDetails = response.body;
                response.errorData = new Map<String, Object>{ 'rawResponse' => response.body };
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
    
    public static ApiResponse listOrders(String brandId, String warehouseId, String status, Integer page, Integer pageSize, String sortBy, String sortDir) {
        String endpoint = '/orders';
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
    
    public static ApiResponse cancelOrder(String id) {
        return handleResponse(getInstance().post('/orders/' + id + '/cancel', ''));
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
            'status' => status
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
    public static ApiResponse getBrand(String brandId) {
        return handleResponse(getInstance().get('/brands/' + brandId));
    }
    
    public static ApiResponse listBrands(Integer page, Integer pageSize, String sortBy, String sortDir) {
        String endpoint = '/brands';
        String queryString = HttpUtils.buildQueryString(new Map<String, String>{
            'page' => String.valueOf(page),
            'pageSize' => String.valueOf(pageSize),
            'sortBy' => sortBy,
            'sortDir' => sortDir
        });
        return handleResponse(getInstance().get(endpoint + queryString));
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
} 