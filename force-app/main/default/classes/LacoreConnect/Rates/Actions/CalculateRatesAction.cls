public class CalculateRatesAction {
    @InvocableMethod(label='Calculate Rates' description='Calculates shipping rates from LacoreConnect' category='Lacore Connect')
    public static List<CalculateRatesResponse> execute(List<CalculateRatesRequest> requests) {
        List<CalculateRatesResponse> responses = new List<CalculateRatesResponse>();
        
        for (CalculateRatesRequest request : requests) {
            try {
                RateRequestDto rateRequest = new RateRequestDto();
                rateRequest.brandId = request.brandId;
                rateRequest.warehouseId = request.warehouseId;
                rateRequest.destination = new AddressDto();
                rateRequest.destination.country = request.destinationCountry;
                rateRequest.destination.state = request.destinationState;
                rateRequest.destination.city = request.destinationCity;
                rateRequest.destination.zip = request.destinationZip;
                rateRequest.destination.address1 = request.destinationAddress1;
                rateRequest.destination.address2 = request.destinationAddress2;
                rateRequest.items = new List<RateItemDto>();
                
                for (RateItem item : request.items) {
                    RateItemDto itemDto = new RateItemDto();
                    itemDto.sku = item.sku;
                    itemDto.quantity = item.quantity;
                    itemDto.weight = item.weight;
                    itemDto.length = item.length;
                    itemDto.width = item.width;
                    itemDto.height = item.height;
                    rateRequest.items.add(itemDto);
                }
                
                LacoreConnectService.ApiResponse response = LacoreConnectService.calculateRates(rateRequest);
                responses.add(new CalculateRatesResponse(response));
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        
        return responses;
    }
    
    public class CalculateRatesRequest {
        @InvocableVariable(required=true)
        public String brandId;
        
        @InvocableVariable(required=true)
        public String warehouseId;
        
        @InvocableVariable(required=true)
        public String destinationCountry;
        
        @InvocableVariable
        public String destinationState;
        
        @InvocableVariable
        public String destinationCity;
        
        @InvocableVariable(required=true)
        public String destinationZip;
        
        @InvocableVariable(required=true)
        public String destinationAddress1;
        
        @InvocableVariable
        public String destinationAddress2;
        
        @InvocableVariable(required=true)
        public List<RateItem> items;
    }
    
    public class RateItem {
        @InvocableVariable(required=true)
        public String sku;
        
        @InvocableVariable(required=true)
        public Integer quantity;
        
        @InvocableVariable(required=true)
        public Decimal weight;
        
        @InvocableVariable(required=true)
        public Decimal length;
        
        @InvocableVariable(required=true)
        public Decimal width;
        
        @InvocableVariable(required=true)
        public Decimal height;
    }
    
    public class CalculateRatesResponse {
        @InvocableVariable
        public Boolean success;
        
        @InvocableVariable
        public String message;
        
        @InvocableVariable
        public String data;
        
        public CalculateRatesResponse(LacoreConnectService.ApiResponse response) {
            this.success = response.isSuccess;
            this.message = response.errorMessage;
            this.data = response.body;
        }
    }
} 