public class StatisticsRequestDto {
    @AuraEnabled public String brandId { get; set; }
    @AuraEnabled public DateTime startDate { get; set; }
    @AuraEnabled public DateTime endDate { get; set; }
    @AuraEnabled public List<StatisticsMetric> metrics { get; set; }
    @AuraEnabled public StatisticsGroupBy groupBy { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
    @AuraEnabled public String warehouseId { get; set; }
    @AuraEnabled public String customerId { get; set; }
    @AuraEnabled public String orderStatus { get; set; }
    @AuraEnabled public String paymentStatus { get; set; }
    @AuraEnabled public String shippingMethod { get; set; }
    @AuraEnabled public String carrier { get; set; }
    @AuraEnabled public String sourceOfOrder { get; set; }
    @AuraEnabled public String storefrontId { get; set; }
    @AuraEnabled public String fulfillmentService { get; set; }
    @AuraEnabled public Boolean includeArchived { get; set; }
    @AuraEnabled public String timezone { get; set; }
    
    public String getGroupByString() {
        return groupBy != null ? groupBy.name().toLowerCase() : null;
    }
    
    public List<String> getMetricsStrings() {
        List<String> metricStrings = new List<String>();
        if (metrics != null) {
            for (StatisticsMetric metric : metrics) {
                metricStrings.add(metric.name().toLowerCase());
            }
        }
        return metricStrings;
    }
} 