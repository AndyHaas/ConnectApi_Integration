public class StatisticsDataPointDto {
    public DateTime timestamp;
    public Map<String, Decimal> metrics;
    public Map<String, Integer> counts;
    public Map<String, Decimal> percentages;
} 