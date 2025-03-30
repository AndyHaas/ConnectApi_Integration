public class StatisticsResponseDto {
    public List<StatisticsDataPointDto> dataPoints;
    public Map<String, Decimal> totals;
    public Map<String, Decimal> averages;
    public Map<String, Decimal> minimums;
    public Map<String, Decimal> maximums;
} 