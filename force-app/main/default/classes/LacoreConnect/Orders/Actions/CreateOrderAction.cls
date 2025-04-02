/**
 * @description Action class for creating and updating orders in LacoreConnect.
 * This class provides an invocable method that can be called from Flow Builder
 * to create or update one or more orders.
 */
public with sharing class CreateOrderAction {
    /**
     * @description Invocable method to create or update orders in LacoreConnect
     * @param requests List of CreateOrderRequest objects containing order data
     * @return List<CreateOrderResponse> List of responses containing operation results
     */
    @InvocableMethod(label='Create/Update Order(s)' description='Create or update one or more orders in Lacore Connect' category='Lacore Connect')
    public static List<CreateOrderResponse> execute(List<CreateOrderRequest> requests) {
        List<CreateOrderResponse> responses = new List<CreateOrderResponse>();
        
        for (CreateOrderRequest request : requests) {
            try {
                if (request.isBulkOperation) {
                    // Handle bulk operation
                    List<OrderDto> orderDtos = new List<OrderDto>();
                    for (OrderRequestData orderData : request.orders) {
                        OrderDto orderDto = createOrderDto(orderData);
                        orderDtos.add(orderDto);
                    }
                    
                    LacoreConnectService.ApiResponse response;
                    if (request.isUpdate) {
                        response = LacoreConnectService.updateOrders(orderDtos);
                    } else {
                        response = LacoreConnectService.createOrders(orderDtos);
                    }
                    responses.add(new CreateOrderResponse(response));
                } else {
                    // Handle single operation
                    OrderDto orderDto = createOrderDto(request.order);
                    
                    LacoreConnectService.ApiResponse response;
                    if (request.isUpdate) {
                        response = LacoreConnectService.updateOrder(orderDto);
                    } else {
                        response = LacoreConnectService.createOrder(orderDto);
                    }
                    responses.add(new CreateOrderResponse(response));
                }
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    /**
     * @description Creates an OrderDto from OrderRequestData
     * @param data The order request data to convert
     * @return OrderDto The created order DTO
     */
    private static OrderDto createOrderDto(OrderRequestData data) {
        OrderDto dto = new OrderDto();
        dto.orderId = data.orderId;
        dto.orderNumber = data.orderNumber;
        dto.orderDateTimeUtc = data.orderDateTimeUtc;
        dto.orderStatus = data.orderStatus;
        dto.orderTotal = data.orderTotal;
        dto.taxAmount = data.taxAmount;
        dto.shippingAmount = data.shippingAmount;
        dto.customerNotes = data.customerNotes;
        dto.storefrontId = data.storefrontId;
        dto.customerEmail = data.customerEmail;
        dto.customerUsername = data.customerUsername;
        dto.billTo = data.billTo;
        dto.shipTo = data.shipTo;
        dto.items = data.items;
        return dto;
    }
    
    /**
     * @description Request class for the CreateOrder action
     */
    public class CreateOrderRequest {
        /** Whether this is a bulk operation */
        @InvocableVariable
        public Boolean isBulkOperation;
        
        /** Whether this is an update operation */
        @InvocableVariable
        public Boolean isUpdate;
        
        /** Single order data for non-bulk operations */
        @InvocableVariable
        public OrderRequestData order;
        
        /** List of order data for bulk operations */
        @InvocableVariable
        public List<OrderRequestData> orders;
    }
    
    /**
     * @description Data class for order request information
     */
    public class OrderRequestData {
        /** The order ID */
        @InvocableVariable(required=true label='Order ID')
        public String orderId;
        
        /** The order number */
        @InvocableVariable(required=true label='Order Number')
        public String orderNumber;
        
        /** The order date/time in UTC */
        @InvocableVariable(label='Order Date Time UTC')
        public DateTime orderDateTimeUtc;
        
        /** The order status */
        @InvocableVariable(required=true label='Order Status')
        public String orderStatus;
        
        /** The order total amount */
        @InvocableVariable(required=true label='Order Total')
        public Decimal orderTotal;
        
        /** The tax amount */
        @InvocableVariable(label='Tax Amount')
        public Decimal taxAmount;
        
        /** The shipping amount */
        @InvocableVariable(label='Shipping Amount')
        public Decimal shippingAmount;
        
        /** Customer notes */
        @InvocableVariable(label='Customer Notes')
        public String customerNotes;
        
        /** The storefront ID */
        @InvocableVariable(required=true label='Storefront ID')
        public String storefrontId;
        
        /** Customer email */
        @InvocableVariable(required=true label='Customer Email')
        public String customerEmail;
        
        /** Customer username */
        @InvocableVariable(label='Customer Username')
        public String customerUsername;
        
        /** Billing address */
        @InvocableVariable(required=true label='Bill To')
        public AddressDto billTo;
        
        /** Shipping address */
        @InvocableVariable(required=true label='Ship To')
        public AddressDto shipTo;
        
        /** Order items */
        @InvocableVariable(required=true label='Order Items')
        public List<OrderItemDto> items;
    }
    
    /**
     * @description Response class for the CreateOrder action
     */
    public class CreateOrderResponse {
        /** Whether the request was successful */
        @InvocableVariable
        public Boolean success;
        
        /** Error message if the request failed */
        @InvocableVariable
        public String message;
        
        /** The order data in JSON format */
        @InvocableVariable
        public OrderDto data;
        
        /** Whether the bulk operation had any errors */
        @InvocableVariable
        public Boolean hasErrors;
        
        /** List of bulk operation results */
        @InvocableVariable
        public List<BulkOrderResult> results;
        
        /**
         * @description Constructor that creates a response from an API response
         * @param response The API response from LacoreConnectService
         */
        public CreateOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            
            if (response.isSuccess) {
                try {
                    // Try to deserialize as bulk response first
                    BulkOrderResponse bulkResponse = (BulkOrderResponse)JSON.deserialize(response.body, BulkOrderResponse.class);
                    this.hasErrors = bulkResponse.hasErrors;
                    this.results = bulkResponse.results;
                } catch (JSONException e) {
                    // If not bulk response, try single order
                    this.data = (OrderDto)JSON.deserialize(response.body, OrderDto.class);
                }
            }
        }
    }
    
    /**
     * @description Response class for bulk order operations
     */
    public class BulkOrderResponse {
        /** Whether any orders in the bulk operation had errors */
        public Boolean hasErrors;
        
        /** List of results for each order in the bulk operation */
        public List<BulkOrderResult> results;
    }
    
    /**
     * @description Result class for individual orders in a bulk operation
     */
    public class BulkOrderResult {
        /** The order ID */
        public String orderId;
        
        /** The order number */
        public String orderNumber;
        
        /** The order key */
        public String orderKey;
        
        /** Whether this specific order was processed successfully */
        public Boolean success;
        
        /** Error message if this specific order failed */
        public String errorMessage;
    }
} 