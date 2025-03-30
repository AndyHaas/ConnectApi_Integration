public class StatisticsRequestDto {
    @AuraEnabled public String brandId { get; set; }
    @AuraEnabled public DateTime startDate { get; set; }
    @AuraEnabled public DateTime endDate { get; set; }
    @AuraEnabled public List<StatisticsMetric> metrics { get; set; }
    @AuraEnabled public StatisticsGroupBy groupBy { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
    
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