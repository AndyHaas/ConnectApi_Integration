public class SplitOrderDto {
    public String id;
    public String orderId;
    public String status;
    public DateTime createdAt;
    public DateTime updatedAt;
    public List<SplitItemDto> items;
    public Map<String, String> metadata;
} 