public with sharing class CreateOrderAction {
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
    
    private static OrderDto createOrderDto(OrderRequestData data) {
        OrderDto orderDto = new OrderDto();
        orderDto.orderId = data.orderId;
        orderDto.shipstationOrderId = data.shipstationOrderId;
        orderDto.orderNumber = data.orderNumber;
        orderDto.orderKey = data.orderKey;
        orderDto.createDateTimeUtc = data.createDateTimeUtc;
        orderDto.modifyDateTimeUtc = data.modifyDateTimeUtc;
        orderDto.orderDateTimeUtc = data.orderDateTimeUtc;
        orderDto.paymentDateTimeUtc = data.paymentDateTimeUtc;
        orderDto.shipByDateTimeUtc = data.shipByDateTimeUtc;
        orderDto.shipDateUtc = data.shipDateUtc;
        orderDto.orderStatus = data.orderStatus;
        orderDto.customerUsername = data.customerUsername;
        orderDto.customerEmail = data.customerEmail;
        orderDto.billTo = data.billTo;
        orderDto.shipTo = data.shipTo;
        orderDto.items = data.items;
        orderDto.orderTotal = data.orderTotal;
        orderDto.amountPaid = data.amountPaid;
        orderDto.shippingAmount = data.shippingAmount;
        orderDto.taxAmount = data.taxAmount;
        orderDto.customerNotes = data.customerNotes;
        orderDto.internalNotes = data.internalNotes;
        orderDto.gift = data.gift;
        orderDto.giftMessage = data.giftMessage;
        orderDto.paymentMethod = data.paymentMethod;
        orderDto.requestedShippingService = data.requestedShippingService;
        orderDto.carrierCode = data.carrierCode;
        orderDto.serviceCode = data.serviceCode;
        orderDto.weight = data.weight;
        orderDto.dimensions = data.dimensions;
        orderDto.tagIds = data.tagIds;
        orderDto.orderGroupId = data.orderGroupId;
        orderDto.sourceOfOrder = data.sourceOfOrder;
        orderDto.storefrontId = data.storefrontId;
        orderDto.fulfilledByService = data.fulfilledByService;
        orderDto.onHoldReason = data.onHoldReason;
        orderDto.holdUntilDate = data.holdUntilDate;
        orderDto.userId = data.userId;
        orderDto.externallyFulfilled = data.externallyFulfilled;
        orderDto.externallyFulfilledBy = data.externallyFulfilledBy;
        orderDto.insuranceOptions = data.insuranceOptions;
        orderDto.internationalOptions = data.internationalOptions;
        orderDto.advancedOptions = data.advancedOptions;
        orderDto.packageCode = data.packageCode;
        orderDto.splitOrderIds = data.splitOrderIds;
        orderDto.confirmation = data.confirmation;
        orderDto.parentReshipOrderId = data.parentReshipOrderId;
        orderDto.parentSplitOrderId = data.parentSplitOrderId;
        orderDto.customData = data.customData;
        return orderDto;
    }
    
    public class CreateOrderRequest {
        @InvocableVariable(required=true label='Is Update Operation')
        public Boolean isUpdate;
        
        @InvocableVariable(required=true label='Is Bulk Operation')
        public Boolean isBulkOperation;
        
        @InvocableVariable(label='Single Order Data')
        public OrderRequestData order;
        
        @InvocableVariable(label='Bulk Orders Data')
        public List<OrderRequestData> orders;
    }
    
    public class OrderRequestData {
        @InvocableVariable(required=true label='Order ID')
        public String orderId;
        
        @InvocableVariable(label='Shipstation Order ID')
        public String shipstationOrderId;
        
        @InvocableVariable(required=true label='Order Number')
        public String orderNumber;
        
        @InvocableVariable(label='Order Key')
        public String orderKey;
        
        @InvocableVariable(label='Create Date Time UTC')
        public DateTime createDateTimeUtc;
        
        @InvocableVariable(label='Modify Date Time UTC')
        public DateTime modifyDateTimeUtc;
        
        @InvocableVariable(label='Order Date Time UTC')
        public DateTime orderDateTimeUtc;
        
        @InvocableVariable(label='Payment Date Time UTC')
        public DateTime paymentDateTimeUtc;
        
        @InvocableVariable(label='Ship By Date Time UTC')
        public DateTime shipByDateTimeUtc;
        
        @InvocableVariable(label='Ship Date UTC')
        public DateTime shipDateUtc;
        
        @InvocableVariable(required=true label='Order Status')
        public String orderStatus;
        
        @InvocableVariable(label='Customer Username')
        public String customerUsername;
        
        @InvocableVariable(required=true label='Customer Email')
        public String customerEmail;
        
        @InvocableVariable(required=true label='Bill To')
        public AddressDto billTo;
        
        @InvocableVariable(required=true label='Ship To')
        public AddressDto shipTo;
        
        @InvocableVariable(required=true label='Order Items')
        public List<OrderItemDto> items;
        
        @InvocableVariable(required=true label='Order Total')
        public Decimal orderTotal;
        
        @InvocableVariable(label='Amount Paid')
        public Decimal amountPaid;
        
        @InvocableVariable(label='Shipping Amount')
        public Decimal shippingAmount;
        
        @InvocableVariable(label='Tax Amount')
        public Decimal taxAmount;
        
        @InvocableVariable(label='Customer Notes')
        public String customerNotes;
        
        @InvocableVariable(label='Internal Notes')
        public String internalNotes;
        
        @InvocableVariable(label='Is Gift')
        public Boolean gift;
        
        @InvocableVariable(label='Gift Message')
        public String giftMessage;
        
        @InvocableVariable(required=true label='Payment Method')
        public String paymentMethod;
        
        @InvocableVariable(label='Requested Shipping Service')
        public String requestedShippingService;
        
        @InvocableVariable(label='Carrier Code')
        public String carrierCode;
        
        @InvocableVariable(label='Service Code')
        public String serviceCode;
        
        @InvocableVariable(label='Weight')
        public WeightDto weight;
        
        @InvocableVariable(label='Dimensions')
        public DimensionsDto dimensions;
        
        @InvocableVariable(label='Tag IDs')
        public List<String> tagIds;
        
        @InvocableVariable(label='Order Group ID')
        public String orderGroupId;
        
        @InvocableVariable(label='Source of Order')
        public String sourceOfOrder;
        
        @InvocableVariable(required=true label='Storefront ID')
        public String storefrontId;
        
        @InvocableVariable(label='Fulfilled By Service')
        public String fulfilledByService;
        
        @InvocableVariable(label='On Hold Reason')
        public String onHoldReason;
        
        @InvocableVariable(label='Hold Until Date')
        public String holdUntilDate;
        
        @InvocableVariable(label='User ID')
        public String userId;
        
        @InvocableVariable(label='Externally Fulfilled')
        public Boolean externallyFulfilled;
        
        @InvocableVariable(label='Externally Fulfilled By')
        public String externallyFulfilledBy;
        
        @InvocableVariable(label='Insurance Options')
        public InsuranceOptionsDto insuranceOptions;
        
        @InvocableVariable(label='International Options')
        public InternationalOptionsDto internationalOptions;
        
        @InvocableVariable(label='Advanced Options')
        public AdvancedOptionsDto advancedOptions;
        
        @InvocableVariable(label='Package Code')
        public String packageCode;
        
        @InvocableVariable(label='Split Order IDs')
        public List<String> splitOrderIds;
        
        @InvocableVariable(label='Confirmation')
        public String confirmation;
        
        @InvocableVariable(label='Parent Reship Order ID')
        public String parentReshipOrderId;
        
        @InvocableVariable(label='Parent Split Order ID')
        public String parentSplitOrderId;
        
        @InvocableVariable(label='Custom Data')
        public List<CustomDataDto> customData;
    }
    
    public class CreateOrderResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public CreateOrderResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 